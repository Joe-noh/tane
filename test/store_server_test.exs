defmodule Tane.StoreServerTest do
  use ExUnit.Case

  alias Tane.StoreServer

  setup do
    StoreServer.start_link
    :ok
  end

  test "store an object" do
    bob = %TestModel{name: "bob", email: "bob@example.com"}
    StoreServer.store(bob)

    assert StoreServer.dump |> Dict.get(TestModel) == [bob]
  end

  test "get_by" do
    bob = %TestModel{name: "bob", email: "bob@example.com"}
    StoreServer.store(bob)

    assert StoreServer.get_by(TestModel, name: "bob") == bob
  end

  test "get_by returns first inserted one" do
    bob1 = %TestModel{name: "bob", email: "bob1@example.com"}
    bob2 = %TestModel{name: "bob", email: "bob2@example.com"}

    StoreServer.store(bob1)
    StoreServer.store(bob2)

    assert StoreServer.get_by(TestModel, name: "bob") == bob1
  end
end

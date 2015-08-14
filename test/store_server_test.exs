defmodule Tane.StoreServerTest do
  use ExUnit.Case

  alias Tane.StoreServer
  alias Tane.User

  setup do
    StoreServer.start_link
    :ok
  end

  test "store an object" do
    bob = %User{name: "bob", email: "bob@example.com"}
    StoreServer.store(bob)

    assert StoreServer.dump |> Dict.get(User) == [bob]
  end

  test "get_by" do
    bob = %User{name: "bob", email: "bob@example.com"}
    StoreServer.store(bob)

    assert StoreServer.get_by(User, name: "bob") == bob
  end

  test "get_by returns first inserted one" do
    bob1 = %User{name: "bob", email: "bob1@example.com"}
    bob2 = %User{name: "bob", email: "bob2@example.com"}

    StoreServer.store(bob1)
    StoreServer.store(bob2)

    assert StoreServer.get_by(User, name: "bob") == bob1
  end
end

defmodule Tane.StoreServerTest do
  use ExUnit.Case

  alias Tane.StoreServer
  alias Tane.User

  setup do
    StoreServer.start_link
    :ok
  end

  test "store and get an object" do
    bob = %User{name: "bob", email: "bob@example.com"}
    StoreServer.store(:bob, bob)

    assert StoreServer.registered(:bob) == bob
  end
end

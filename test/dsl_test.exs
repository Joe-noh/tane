defmodule Tane.DSLTest do
  use ExUnit.Case, async: false

  import Tane.DSL

  alias Tane.Repo
  alias Tane.User

  test "repo" do
    assert repo(Repo) == %Tane{repo: Repo}
  end

  test "model" do
    assert model(User) == %Tane{model: User}
  end

  test "seed" do
    Tane.StoreServer.start_link

    tane = repo(Repo) |> model(User) |> delete_all!

    assert seed(tane, name: "bob") == tane
    assert Enum.count(Repo.all User) == 1
  end

  test "delete_all! raises when repo is not provided" do
    tane = model(User)

    assert_raise ArgumentError, ~r/repo is required/, fn ->
      tane |> delete_all!
    end
  end

  test "delete_all! raises when model is not provided" do
    tane = repo(Repo)

    assert_raise ArgumentError, ~r/model is required/, fn ->
      tane |> delete_all!
    end
  end

  test "delete_all!" do
    tane = repo(Repo) |> model(User)

    assert delete_all!(tane) == tane
    assert Enum.count(Repo.all User) == 0
  end
end

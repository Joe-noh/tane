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
end

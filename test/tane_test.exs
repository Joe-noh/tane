defmodule TaneTest do
  use ExUnit.Case

  test "init" do
    assert Tane.init == %Tane{}
  end

  test "repo" do
    assert Tane.init |> Tane.repo(MyApp.Repo) == %Tane{repo: MyApp.Repo}
  end

  test "model" do
    assert Tane.init |> Tane.model(MyApp.User) == %Tane{model: MyApp.User}
  end

  test "delete_all! raises when repo is not provided" do
    tane = Tane.init |> Tane.model(MyApp.User)

    assert_raise ArgumentError, ~r/repo is required/, fn ->
      tane |> Tane.delete_all!
    end
  end

  test "delete_all! raises when model is not provided" do
    tane = Tane.init |> Tane.repo(MyApp.Repo)

    assert_raise ArgumentError, ~r/model is required/, fn ->
      tane |> Tane.delete_all!
    end
  end

  test "delete_all invokes repo.delete_all" do
    tane = Tane.init
      |> Tane.repo(MyApp.Repo)
      |> Tane.model(MyApp.User)

    message_regexp = ~r(undefined function: MyApp\.Repo\.delete_all/1)
    assert_raise UndefinedFunctionError, message_regexp, fn ->
      tane |> Tane.delete_all!
    end
  end

  test "integration" do
    tane = Tane.init
      |> Tane.repo(MyApp.Repo)
      |> Tane.model(MyApp.User)

    # It is bother to setup ecto for only testing.
    # Just verify `MyApp.User.changeset/1` is called.

    message_regexp = ~r(undefined function: MyApp\.User\.changeset/2)
    assert_raise UndefinedFunctionError, message_regexp, fn ->
      tane |> Tane.seed(name: "bob")
    end
  end
end

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

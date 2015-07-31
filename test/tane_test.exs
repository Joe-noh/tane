defmodule TaneTest do
  use ExUnit.Case

  @insert_is_called     "MyApp.Repo.insert! is called"
  @delete_all_is_called "MyApp.Repo.delete_all is called"

  setup_all do
    :meck.new(MyApp.Repo, [:non_strict, :non_link])
    :meck.new(MyApp.User, [:non_strict, :non_link])

    :meck.expect(MyApp.Repo, :insert!,    1, @insert_is_called)
    :meck.expect(MyApp.Repo, :delete_all, 1, @delete_all_is_called)

    :meck.expect(MyApp.User, :__struct__, 0, %{})
    :meck.expect(MyApp.User, :changeset, 2, %{})
  end

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

    assert Tane.delete_all!(tane) == @delete_all_is_called
  end

  test "integration" do
    tane = Tane.init
      |> Tane.repo(MyApp.Repo)
      |> Tane.model(MyApp.User)

    assert Tane.seed(tane, name: "bob") == %Tane{repo: MyApp.Repo, model: MyApp.User}
  end
end

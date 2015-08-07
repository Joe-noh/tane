defmodule TaneTest do
  use ExUnit.Case

  setup_all do
    :meck.new(Repo, [:non_strict, :non_link])
    :meck.new(User, [:non_strict, :non_link])

    :meck.expect(Repo, :insert!,    1, %{model: User})
    :meck.expect(Repo, :insert!,    2, %{model: User})
    :meck.expect(Repo, :delete_all, 1, {1, nil})
    :meck.expect(Repo, :delete_all, 2, {2, nil})

    :meck.expect(User, :__struct__, 0, %{struct: User})
    :meck.expect(User, :changeset,  2, %{struct: Ecto.Changeset})
  end

  setup do
    on_exit fn ->
      :meck.reset(Repo)
      :meck.reset(User)
    end
  end

  test "init" do
    assert Tane.init == %Tane{}
    assert Tane.init(Repo, User) == %Tane{repo: Repo, model: User}
  end

  test "repo" do
    assert Tane.init |> Tane.repo(Repo) == %Tane{repo: Repo}
  end

  test "model" do
    assert Tane.init |> Tane.model(User) == %Tane{model: User}
  end

  test "delete_all! raises when repo is not provided" do
    tane = Tane.init |> Tane.model(User)

    assert_raise ArgumentError, ~r/repo is required/, fn ->
      tane |> Tane.delete_all!
    end
  end

  test "delete_all! raises when model is not provided" do
    tane = Tane.init |> Tane.repo(Repo)

    assert_raise ArgumentError, ~r/model is required/, fn ->
      tane |> Tane.delete_all!
    end
  end

  test "delete_all returns " do
    tane = Tane.init
      |> Tane.repo(Repo)
      |> Tane.model(User)

    assert Tane.delete_all!(tane) == tane
    assert :meck.num_calls(Repo, :delete_all, 1) == 1
  end

  test "integration" do
    tane = Tane.init
      |> Tane.repo(Repo)
      |> Tane.model(User)

    assert Tane.seed(tane, name: "bob") == tane
    assert :meck.num_calls(Repo, :insert!, 1) == 1
  end
end

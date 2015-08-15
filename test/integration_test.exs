defmodule Tane.IntegrationTest do
  use ExUnit.Case, async: false

  alias Tane.Repo
  alias Tane.User
  alias Tane.Post

  import Ecto.Query, only: [from: 2]
  import TestHelper

  setup do
    Repo.delete_all(Post)
    Repo.delete_all(User)

    :ok
  end

  test "integration" do
    script = """
    use Tane

    alias Tane.Repo
    alias Tane.User
    alias Tane.Post

    repo(Repo)
    |> model(User)
    |> delete_all!
    |> seed(:john, name: "john", email: "john@example.com")
    |> seed(name: "mary", email: "mary@example.com")
    |> seed(name: "alex", email: "alex@example.com")
    |> model(Post)
    |> delete_all!
    |> seed(title: "hello", user_id: registered(:john).id)
    |> seed(title: "world", user_id: registered(:john).id)
    """
    path = Path.join(System.tmp_dir, "integration.exs")

    File.write!(path, script)

    Mix.Task.run "tane", ["--path", path]

    assert Enum.count(Repo.all User) == 3
    assert Enum.count(Repo.all Post) == 2

    john  = Repo.one(from u in User, where: u.name == "john", preload: :posts)
    posts = Repo.all(from p in Post, join: u in assoc(p, :user), preload: [user: u])

    assert titles(john.posts) -- titles(posts) == []
    assert titles(posts) -- titles(john.posts) == []

    assert Repo.preload(hd(posts), :user).user.id == john.id
  end
end

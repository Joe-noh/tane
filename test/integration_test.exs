defmodule Tane.IntegrationTest do
  use ExUnit.Case, async: false

  alias Tane.Repo
  alias Tane.User

  test "integration" do
    script = """
    use Tane

    repo(Tane.Repo)
    |> model(Tane.User)
    |> delete_all!
    |> seed(name: "bob",  email: "bob@example.com")
    |> seed(name: "mary", email: "mary@example.com")
    |> seed(name: "alex", email: "alex@example.com")
    """
    path = Path.join(System.tmp_dir, "integration_01.exs")

    File.write!(path, script)

    Mix.Task.run "tane", ["--path", path]

    assert Enum.count(Repo.all User) == 3
  end
end

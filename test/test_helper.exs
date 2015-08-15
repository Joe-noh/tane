ExUnit.start()

Tane.Repo.start_link()

Mix.Task.run "ecto.create",  ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]

defmodule TestHelper do
  def titles(structs) do
    Enum.map(structs, &(&1.title))
  end
end

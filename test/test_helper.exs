ExUnit.start()

Tane.Repo.start_link()

Mix.Task.run "ecto.create",  ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]

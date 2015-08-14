use Mix.Config

config :tane, Tane.Repo,
  adapter: Sqlite.Ecto,
  database: "test/support/test.sqlite3"

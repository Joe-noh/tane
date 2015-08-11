defmodule Mix.Tasks.Tane do
  @moduledoc """
  This task executes seeding.

  ## Options

    * `--path` - path to the seed exs files. defaults to `priv/repo/seeds.exs`
  """

  @shortdoc "insert seeds"

  use Mix.Task

  @default_path Path.join(~w[priv repo seeds.exs])

  def run(args) do
    {opts, _argv, _errors} = OptionParser.parse(args)

    path = Keyword.get(opts, :path, @default_path)

    Mix.Task.run("app.start", [])
    Tane.StoreServer.start_link

    Code.eval_file(path)
  end
end

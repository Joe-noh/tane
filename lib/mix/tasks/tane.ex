defmodule Mix.Tasks.Tane do
  @moduledoc """
  This task executes seeding.

  ## Options

    * `--path` - path to directory that contains seed exs files.
      defaults to `priv/repo/seeds`
  """

  @shortdoc "insert seeds"

  use Mix.Task

  @default_path Path.join(~w[priv repo seeds])

  def run(args) do
    {opts, _argv, _errors} = OptionParser.parse(args)

    path = Keyword.get(opts, :path, @default_path)

    Mix.Task.run("app.start", [])
    seed(path)
  end

  defp seed(path) do
    [path, "*.exs"]
    |> Path.join
    |> Path.wildcard
    |> Enum.each(&Code.eval_file/1)
  end
end

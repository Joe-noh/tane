defmodule Mix.Tasks.Tane do
  @shortdoc "seed!!"

  use Mix.Task

  IO.inspect Code.require_file("mix.exs")
  IO.inspect Mix.Project.config
  @project_name Mix.Project.get |> Module.split |> List.first

  def run(opts \\ []) do
    project_module = modulize(@project_name)

    repo_module = Keyword.get(opts, :repo, Repo)
    repo_full_module = Module.concat(project_module, repo_module)

    ["priv", Mix.Utils.underscore(repo_module), "seeds", "*.exs"]
    |> Path.join
    |> Path.wildcard
    |> Enum.map(&extract_seeds/1)
    |> Enum.map(&insert_seeds(&1, repo_full_module))
  end

  defp extract_seeds(seed_file) do
    {attrs, _bindings} = Code.eval_file(seed_file)
    model_module = seed_file
      |> Path.rootname
      |> Path.basename
      |> Mix.Utils.camelize
      |> prepend_project_name
      |> modulize

    {model_module, attrs}
  end

  defp insert_seeds({model, seeds}, repo) do
    Enum.map seeds, fn seed ->
      apply(repo, :insert!, [struct(model, seed)])
    end
  end

  defp prepend_project_name(module_name) do
    Module.concat @project_name, module_name
  end

  defp modulize(string) do
    Module.concat("Elixir", string)
  end
end

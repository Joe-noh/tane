defmodule Tane do
  defstruct [:repo, :model]

  def init do
    %__MODULE__{}
  end

  def repo(tane, repo_module) do
    %__MODULE__{tane | repo: repo_module}
  end

  def model(tane, model_module) do
    %__MODULE__{tane | model: model_module}
  end

  def seed(tane = %__MODULE__{repo: repo_module, model: model_module}, row) do
    model = struct(model_module, row)
    apply(repo_module, :insert!, [model])

    tane
  end
end

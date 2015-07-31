defmodule Tane do
  @moduledoc """
  This module provides some functions to insert seeds.

      import Tane

      init
      |> repo(MyApp.Repo)
      |> model(MyApp.User)
      |> seed(name: "Bob",  email: "bob@black.com")
      |> seed(name: "Mary", email: "mary@blue.com")
  """

  @type t :: %__MODULE__{}

  defstruct [:repo, :model]

  @spec init() :: t
  def init do
    %__MODULE__{}
  end

  @spec repo(t, atom) :: t
  def repo(tane, repo_module) do
    %__MODULE__{tane | repo: repo_module}
  end

  @spec model(t, atom) :: t
  def model(tane, model_module) do
    %__MODULE__{tane | model: model_module}
  end

  @spec delete_all!(t) :: t | no_return
  def delete_all!(%__MODULE__{repo: nil}) do
    raise ArgumentError, "repo is required to delete all entries"
  end

  def delete_all!(%__MODULE__{model: nil}) do
    raise ArgumentError, "model is required to delete all entries"
  end

  def delete_all!(%__MODULE__{repo: repo, model: model}) do
    apply(repo, :delete_all, [model])
  end

  @spec seed(t, Keyword.t) :: t
  def seed(tane = %__MODULE__{repo: repo_module, model: model_module}, row) do
    model = struct(model_module, row)
    apply(repo_module, :insert!, [model])

    tane
  end
end

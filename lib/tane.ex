defmodule Tane do
  @moduledoc """
  This module provides some functions to insert seeds.

      import Tane

      repo(MyApp.Repo)
      |> model(MyApp.User)
      |> seed(name: "Bob",  email: "bob@black.com")
      |> seed(name: "Mary", email: "mary@blue.com")
  """

  @type t :: %__MODULE__{}

  defstruct [:repo, :model]

  @spec repo(atom) :: t
  def repo(repo_module) do
    %__MODULE__{repo: repo_module}
  end

  @spec repo(t, atom) :: t
  def repo(tane, repo_module) do
    %__MODULE__{tane | repo: repo_module}
  end

  @spec model(atom) :: t
  def model(model_module) do
    %__MODULE__{model: model_module}
  end

  @spec model(t, atom) :: t
  def model(tane, model_module) do
    %__MODULE__{tane | model: model_module}
  end

  @spec delete_all!(t) :: t | no_return
  @doc """
  Delete all entries stored in the repository.
  Internally invokes `repo.delete_all(model)`.
  """
  def delete_all!(%__MODULE__{repo: nil}) do
    raise ArgumentError, "repo is required to delete all entries"
  end

  def delete_all!(%__MODULE__{model: nil}) do
    raise ArgumentError, "model is required to delete all entries"
  end

  def delete_all!(tane = %__MODULE__{repo: repo, model: model}) do
    apply(repo, :delete_all, [model])
    tane
  end

  @spec seed(t, map | Keyword.t) :: t
  def seed(tane, row) when is_map(row) do
    do_seed(tane, row)
  end

  def seed(tane, row) do
    do_seed(tane, Enum.into(row, %{}))
  end

  @spec do_seed(t, map) :: t
  defp do_seed(tane = %__MODULE__{repo: repo_module, model: model_module}, row) do
    row = row |> Enum.into %{}

    model = struct(model_module, [])
    changeset = apply(model_module, :changeset, [model, row])
    apply(repo_module, :insert!, [changeset])

    tane
  end
end

defmodule Tane.DSL do

  defdelegate get_by(module, conditions), to: Tane.StoreServer

  @spec repo(atom) :: Tane.t
  def repo(repo_module) do
    %Tane{repo: repo_module}
  end

  @spec repo(Tane.t, atom) :: Tane.t
  def repo(tane, repo_module) do
    %Tane{tane | repo: repo_module}
  end

  @spec model(atom) :: Tane.t
  def model(model_module) do
    %Tane{model: model_module}
  end

  @spec model(Tane.t, atom) :: Tane.t
  def model(tane, model_module) do
    %Tane{tane | model: model_module}
  end

  @spec delete_all!(Tane.t) :: Tane.t | no_return
  @doc """
  Delete all entries stored in the repository.
  Internally invokes `repo.delete_all(model)`.
  """
  def delete_all!(%Tane{repo: nil}) do
    raise ArgumentError, "repo is required to delete all entries"
  end

  def delete_all!(%Tane{model: nil}) do
    raise ArgumentError, "model is required to delete all entries"
  end

  def delete_all!(tane = %Tane{repo: repo, model: model}) do
    apply(repo, :delete_all, [model])
    tane
  end

  @spec seed(Tane.t, map | Keyword.t) :: Tane.t
  def seed(tane, row) when is_map(row) do
    do_seed(tane, row)
  end

  def seed(tane, row) do
    do_seed(tane, Enum.into(row, %{}))
  end

  @spec do_seed(Tane.t, map) :: Tane.t
  defp do_seed(tane = %Tane{repo: repo_module, model: model_module}, row) do
    row = row |> Enum.into %{}

    model = struct(model_module, [])
    changeset = apply(model_module, :changeset, [model, row])
    inserted = apply(repo_module, :insert!, [changeset])

    Tane.StoreServer.store(inserted)
    tane
  end
end

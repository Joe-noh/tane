defmodule Tane.DSL do

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

  @spec seed(Tane.t, Keyword.t) :: Tane.t
  def seed(tane, row) do
    do_seed(tane, row)
    tane
  end

  @spec seed(Tane.t, atom, Keyword.t) :: Tane.t
  def seed(tane, name, row) do
    inserted = do_seed(tane, row)
    Tane.StoreServer.store(name, inserted)

    tane
  end

  @spec do_seed(Tane.t, Keyword.t) :: Tane.t
  defp do_seed(%Tane{repo: repo_module, model: model_module}, row) do
    model = struct(model_module, row)
    apply(repo_module, :insert!, [model])
  end

  @spec registered(atom) :: term
  def registered(name) do
    Tane.StoreServer.registered(name)
  end
end

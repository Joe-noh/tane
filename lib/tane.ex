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

  defmacro __using__(_opts) do
    quote do
      import Tane.DSL
    end
  end
end

defmodule Tane.User do
  use Ecto.Model

  schema "users" do
    field :name,  :string
    field :email, :string

    timestamps
  end

  @requireds ~w[name]
  @optionals ~w[email]

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @requireds, @optionals)
  end
end

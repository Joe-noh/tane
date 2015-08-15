defmodule Tane.Post do
  use Ecto.Model

  schema "posts" do
    field :title, :string
    field :body,  :string

    belongs_to :user, User

    timestamps
  end
end

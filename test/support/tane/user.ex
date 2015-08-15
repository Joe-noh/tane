defmodule Tane.User do
  use Ecto.Model

  schema "users" do
    field :name,  :string
    field :email, :string

    has_many :posts, Post

    timestamps
  end
end

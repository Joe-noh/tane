defmodule Tane.User do
  use Ecto.Model

  alias Tane.Post

  schema "users" do
    field :name,  :string
    field :email, :string

    has_many :posts, Post, on_delete: :delete_all

    timestamps
  end
end

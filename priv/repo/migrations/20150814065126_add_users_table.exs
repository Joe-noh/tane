defmodule Tane.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name,  :string
      add :email, :string

      timestamps
    end
  end
end

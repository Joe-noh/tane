defmodule Tane.Repo.Migrations.AddPostsTable do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title,   :string
      add :body,    :string
      add :user_id, references(:users)

      timestamps
    end

    create index(:posts, [:user_id])
   end
end

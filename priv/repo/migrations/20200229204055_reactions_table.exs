defmodule Bodegacats.Repo.Migrations.ReactionsTable do
  use Ecto.Migration

  def change do
    alter table(:cats) do
      remove :like
      remove :laugh
      remove :scream
    end

    create table(:reactions) do
      add :type, :string
      add :cat_id, references(:cats)
      add :user_id, :string
    end
  end
end

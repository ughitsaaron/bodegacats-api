defmodule Bodegacats.Repo.Migrations.AddPhotosForeignKey do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :cat_id, references(:cats)
      add :created_by, references(:users)
    end
  end
end

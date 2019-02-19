defmodule Bodegacats.Repo.Migrations.CascadePhotos do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      remove :cat_id
      add :cat_id, references(:cats, on_delete: :delete_all)
    end
  end
end

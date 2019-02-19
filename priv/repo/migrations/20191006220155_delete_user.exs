defmodule Bodegacats.Repo.Migrations.DeleteUser do
  use Ecto.Migration

  def change do
    alter table(:cats) do
      remove :created_by
    end
    alter table(:photos) do
      remove :created_by
    end
    drop table(:users)
  end
end

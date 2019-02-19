defmodule Bodegacats.Repo.Migrations.ChangeTableNames do
  use Ecto.Migration

  def change do
    rename table(:cat), to: table(:cats)
    rename table(:user), to: table(:users)
    rename table(:photo), to: table(:photos)
  end
end

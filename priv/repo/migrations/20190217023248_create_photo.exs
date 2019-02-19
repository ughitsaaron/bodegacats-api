defmodule Bodegacats.Repo.Migrations.CreatePhoto do
  use Ecto.Migration

  def change do
    create table(:photo) do

      timestamps()
    end

  end
end

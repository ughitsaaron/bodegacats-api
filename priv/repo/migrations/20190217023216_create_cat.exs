defmodule Bodegacats.Repo.Migrations.CreateCat do
  use Ecto.Migration

  def change do
    create table(:cat) do
      add :lat, :float
      add :lng, :float

      timestamps()
    end

  end
end

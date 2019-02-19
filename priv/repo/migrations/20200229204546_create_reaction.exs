defmodule Bodegacats.Repo.Migrations.CreateReaction do
  use Ecto.Migration

  def change do
    alter table(:reactions) do
      timestamps()
    end

  end
end

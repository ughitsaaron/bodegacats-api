defmodule Bodegacats.Repo.Migrations.AddReactions do
  use Ecto.Migration

  def change do
    alter table(:cats) do
      add :like, {:array, :string}
      add :laugh, {:array, :string}
      add :scream, {:array, :string}
    end
  end
end

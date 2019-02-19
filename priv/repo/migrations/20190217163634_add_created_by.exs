defmodule Bodegacats.Repo.Migrations.AddCreatedBy do
  use Ecto.Migration

  def change do
    alter table("cat") do
      add :created_by, :integer
    end
  end
end

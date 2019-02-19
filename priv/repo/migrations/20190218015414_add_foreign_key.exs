defmodule Bodegacats.Repo.Migrations.AddForeignKey do
  use Ecto.Migration

  def change do
    alter table("cat") do
      remove(:created_by)
      add :created_by, references(:user)
    end
  end
end

defmodule Bodegacats.Repo.Migrations.AddUserToken do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :token, :text
    end
  end
end

defmodule Bodegacats.Root.Cat do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cats" do
    field :lat, :float
    field :lng, :float

    timestamps()
  end

  @doc false
  def changeset(cat, attrs) do
    cat
    |> cast(attrs, [:lat, :lng])
    |> validate_required([:lat, :lng])
  end
end

defmodule Bodegacats.Root.Photo do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bodegacats.Root.Cat

  schema "photos" do
    belongs_to :cat, Cat
    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:cat_id])
    |> validate_required([:cat_id])
  end
end

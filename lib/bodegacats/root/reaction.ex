defmodule Bodegacats.Root.Reaction do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bodegacats.Root.Cat

  schema "reactions" do
    field :type, :string
    belongs_to :cat, Cat
    field :user_id, :string

    timestamps()
  end

  @doc false
  def changeset(reaction, attrs) do
    reaction
    |> cast(attrs, [:type, :cat_id, :user_id])
    |> validate_required([:type, :cat_id, :user_id])
  end
end

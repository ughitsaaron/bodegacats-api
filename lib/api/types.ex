defmodule Bodegacats.Schema.Types do
  use Absinthe.Schema.Notation
  alias Bodegacats.Schema.Resolvers

  object :cat do
    field :id, :id
    field :lat, :float
    field :lng, :float
    field :inserted_at, :string

    field :photos, list_of(:photo) do
      resolve(&Resolvers.get_photos/3)
    end

    field :reactions, list_of(:reaction) do
      resolve(&Resolvers.get_reactions/3)
    end
  end

  object :reaction do
    field :id, :id
    field :type, :string
    field :user_id, :id

    field :cat, :cat do
      resolve(&Resolvers.get_cat/3)
    end
  end

  object :photo do
    field :id, :id
    field :inserted_at, :string

    field :cat, :cat do
      resolve(&Resolvers.get_cat/3)
    end
  end
end

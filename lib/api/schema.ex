defmodule Bodegacats.Schema do
  alias Bodegacats.Schema.Resolvers

  use Absinthe.Schema
  import_types(Bodegacats.Schema.Types)
  import_types(Absinthe.Plug.Types)

  query do
    field :cats, list_of(:cat) do
      resolve(&Resolvers.list_cats/3)
    end

    field :cat, :cat do
      arg(:id, non_null(:id))
      resolve(&Resolvers.get_cat/3)
    end

    field :photos, list_of(:photo) do
      resolve(&Resolvers.get_photos/3)
    end

    field :photo, :photo do
      arg(:id, non_null(:id))
      resolve(&Resolvers.get_photo/3)
    end
  end

  mutation do
    field :create_cat, type: :cat do
      arg(:lat, non_null(:float))
      arg(:lng, non_null(:float))
      resolve(&Resolvers.create_cat/3)
    end

    field :delete_cat, type: :cat do
      arg(:id, non_null(:id))
      arg(:key, non_null(:string))
      resolve(&Resolvers.delete_cat/3)
    end

    field :add_reaction, type: :reaction do
      arg(:type, non_null(:string))
      arg(:cat_id, non_null(:id))
      arg(:user_id, non_null(:id))
      resolve(&Resolvers.add_reaction/3)
    end

    field :remove_reaction, type: :reaction do
      arg(:type, non_null(:string))
      arg(:cat_id, non_null(:id))
      arg(:user_id, non_null(:id))
      resolve(&Resolvers.remove_reaction/3)
    end

    field :create_photo, type: :photo do
      arg(:cat_id, non_null(:id))
      arg(:photo_upload, :upload)
      resolve(&Resolvers.create_photo/3)
    end
  end
end

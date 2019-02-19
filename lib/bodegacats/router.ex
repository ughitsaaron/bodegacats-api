defmodule BodegacatsWeb.Router do
  use BodegacatsWeb, :router

  scope "/" do
    forward "/graphql", Absinthe.Plug, schema: Bodegacats.Schema
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Bodegacats.Schema
  end
end

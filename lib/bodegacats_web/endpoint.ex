defmodule BodegacatsWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :bodegacats

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason

  plug Plug.MethodOverride
  plug Plug.Head
  plug CORSPlug

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  plug Plug.Session,
    store: :cookie,
    key: "_bodegacats_key",
    signing_salt: "mx5TwDpq"

  plug BodegacatsWeb.Router
end

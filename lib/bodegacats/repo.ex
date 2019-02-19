defmodule Bodegacats.Repo do
  use Ecto.Repo,
    otp_app: :bodegacats,
    adapter: Ecto.Adapters.Postgres
end

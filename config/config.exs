# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bodegacats,
  ecto_repos: [Bodegacats.Repo],
  admin_key: System.get_env("ADMIN_KEY")

# Configures the endpoint
config :bodegacats, BodegacatsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Jl8fZgPJoCpNCispBT+boUlqWnowZxTnVGx8byvAutkYmSFySDFMBjyMyYlTMKM8",
  render_errors: [view: BodegacatsWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Bodegacats.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_aws,
  region: "us-east-1"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

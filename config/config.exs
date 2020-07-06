# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :class_management_api,
  ecto_repos: [ClassManagementApi.Repo]

# Configures the endpoint
config :class_management_api, ClassManagementApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JSYS3rh2ybdfGwysP1H/qp2U4c4wV1qR01biMtn41gVk3RygZmOAJXxJFexp3G3y",
  render_errors: [view: ClassManagementApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ClassManagementApi.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "mTF+ygU6"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Use Joken for JWT Auth
config :joken, default_signer: "secret"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

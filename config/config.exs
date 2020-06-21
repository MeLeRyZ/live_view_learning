# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_learn,
  ecto_repos: [LiveLearn.Repo]

# Configures the endpoint
config :live_learn, LiveLearnWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EGkPGpDUq98789BqzWHGNYnRktEZJRM4hEuJxFe7fsEY8JAKgIDKZmWJOtrieAFi",
  render_errors: [view: LiveLearnWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveLearn.PubSub,
  live_view: [signing_salt: "cWz9werR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

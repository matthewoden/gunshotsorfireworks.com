# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :gunshots_ui, GunshotsUi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wS131NgycYOPG1mlFKllQ9J/InCGZOpFIyxtjTBLlOuc1jA1mP9QL61oQgTfLr5m",
  render_errors: [view: GunshotsUi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GunshotsUi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

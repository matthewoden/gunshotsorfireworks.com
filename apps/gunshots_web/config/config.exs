# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :gunshots_web, GunshotsWeb.Endpoint,
  url: [host: "localhost"],
  debug_errors: false,
  secret_key_base: "6ZMFDl8N2kx0waX+LyglHaJ0tErILBdV/hLF4Iimw0fmHCk/wFHzCLzEI/b0K0Xd",
  render_errors: [view: GunshotsWeb.ErrorView, accepts: ~w(html json), default_format: "json"],
  pubsub: [name: GunshotsWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

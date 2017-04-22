use Mix.Config


config :cfs, :store, cache_policy: nil


# Finally import the config/prod.secret.exs
# which should be versioned separately.
import_config "prod.secret.exs"

use Mix.Config

# for development, and production, we call out to live services.
# for testing, we mock out a response.

config :cfs,
  dynamo: [table_name: "gunshots-or-fireworks-dev"],
  store:  [cache_policy: :fetch]

# Finally import the config/dev.secret.exs
# which should be versioned separately.
    import_config "dev.secret.exs"

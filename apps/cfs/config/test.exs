use Mix.Config

# Print only warnings and errors during test
config :logger, level: :warn


config :ex_aws,
   access_key_id: System.get_env("GUNSHOTS_AWS_ACCESS_KEY_ID"),
   secret_access_key: System.get_env("GUNSHOTS_AWS_SECRET_ACCESS_KEY"),
   region: "us-east-1"


config :cfs,
  dynamo: [table_name: "gunshots-or-fireworks-test"],
  store:  [cache_policy: nil]

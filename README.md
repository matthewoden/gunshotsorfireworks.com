# Gunshots

This is the Application layer for Gunshots or Fireworks. It's an elixir umbrella app, broken into the following parts:

1. `gunshots_ui` - the web interface, providing the "gunshots or fireworks" api for accessing records within the last 15 minutes.
1. `cfs` - short for `Calls for Service`, it's a scraper that fetches/parses/caches gunshot or firework-related events from the St. Louis Metro police department's Calls For Service site.
1. `cron` - a naive cron service. Runs tasks based on other application's environment variables.


## Hierarchy
`gunshots_web` depends on `cfs`. `cfs` depends on `cron` (though only through configuration)


## Running Locally

Assuming you have erlang/elixir installed, kick off `iex -S mix phoenix.server` at the project root.

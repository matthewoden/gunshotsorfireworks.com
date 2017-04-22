# Cron

Very basic Cronjob app. Doesn't use cron expressions, instead relying on `process.send_after()` to schedule each task. Grabs all environment variables for `:cron`, and creates a list of tasks.


## Example
In your mix config, you might have something like this:

``` elixir
    config :cron, cfs: [%{name: :scrape, job: {CallsForService, :get_new, []},
                         rate: 1000*60*2},
                        %{name: :clean, job: {CallsForService, :clean_expired, []},
                         rate: 1000*60*60}]

```

**name** the name of the job - must be unique across all applications - duplicates 
never get called.

**job** Module, Method, Args

**rate** Time, in milliseconds, between runs. The time a task starts/ends has no effect 
on when the next task runs 


## Roadmap?
 - Warn about duped tasks, I guess.
 - Handle large time intervals. (I eventually want weekly reports)

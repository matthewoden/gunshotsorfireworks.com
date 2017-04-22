defmodule Cron.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    state = Cron.Config.get()

    children = [
      worker(Cron, [state], restart: :permanent)
    ]

    opts = [strategy: :one_for_one, name: Cron.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

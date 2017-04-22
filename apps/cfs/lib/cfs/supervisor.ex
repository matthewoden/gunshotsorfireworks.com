defmodule CallsForService.Supervisor do
  use Supervisor

  alias CallsForService.Config

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    :inets.start() 

    children = [
      worker(
        CallsForService.Store,
        [Config.get_cache_policy],
        restart: :permanent
      ),
    ]

    opts = [strategy: :one_for_one, name: CallsForService.Supervisor]
    supervise(children, opts)
  end
end

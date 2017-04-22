defmodule Cron do
  require Logger

  use GenServer

  alias Cron.Scheduler


  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    Scheduler.schedule_all(state)

    {:ok, state}
  end

  def handle_info(name, state) do
    state
    |> Enum.find(fn (job) -> job.name == name end)
    |> run

    {:noreply, state}
  end

  defp run(nil), do: nil

  defp run(job) do
    # run a task, completely unconnected to the current task,
    # and without regard of the result.
    Task.start(Scheduler, :execute, [job])
    Scheduler.schedule_single(job)
  end

 end

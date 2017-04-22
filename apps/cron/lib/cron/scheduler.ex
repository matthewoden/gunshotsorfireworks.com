defmodule Cron.Scheduler do
  require Logger

  def schedule_all(jobs) do
    Logger.info("Scheduling")
    Enum.each jobs, &schedule_single(&1)
  end

  def schedule_single(%{name: name, rate: rate}) do
    Process.send_after(self(), name, rate)
  end

  def execute(item) do
    Logger.debug("Running Job #{item.name}")

    {module, method, args} = item.job
    :erlang.apply(module, method, args)
  end

end

defmodule CallsForService do
  use Application

  require Logger

  alias CallsForService.{Store, Scraper, Time}


  def start(_type, _args) do
    {:ok, pid} = CallsForService.Supervisor.start_link()
    init(pid)
  end

  defp init(state) do
    get_new()
    {:ok, state }
  end

  @spec get_recent :: %{last_fetched: String.t, records: list({})}
  def get_recent do
    Store.get_all()
    |> Map.update(:records, [], &filter_recent(&1))
  end

  def get_all do
    Store.get_all()
    |> Map.update(:records, [], &sorted_by_time(&1))
  end

  defp filter_recent(records) do
    records
    |> Stream.filter(fn (record) -> Time.happened_recently?(record.time) end)
    |> sorted_by_time
  end

  defp sorted_by_time(records) do
    Enum.sort(records, fn (a, b) -> a.time > b.time end)
  end



  ##########################K
  # Tasks

  @spec get_new :: :ok
  def get_new do
    Scraper.get_calls_for_service()
    |> Stream.reject(&Store.is_member?/1)
    |> Stream.map(fn (item) ->
          coordinates = Scraper.get_coordinates(item.location)
          %{item | coordinates: coordinates }
        end)
    |> Enum.filter(fn (item) -> item.coordinates end)
    |> Store.put_records(Time.now())

  end

  @spec cleanup_expired :: :ok
  def cleanup_expired do
    Store.get_records()
    |> Stream.filter(fn (record) -> Time.happened_yesterday?(record.time) end)
    |> Stream.map(fn (record) -> record.id end)
    |> Enum.to_list()
    |> Store.filter_records
  end

end

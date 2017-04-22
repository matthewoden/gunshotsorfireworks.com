defmodule CallsForService.Store do
  require Logger

  alias CallsForService.Dynamo
  alias CallsForService.Time


  @initial_state %{last_fetched: "", records: %{} } 

  @spec start_link(cache_policy :: :fetch | nil) :: {:ok, pid } | {:error, term }
  def start_link(cache_policy) do
    Agent.start_link(fn -> get_initial_state(cache_policy) end, name: __MODULE__)
  end

  def get_initial_state(:fetch), do: restore()
  def get_initial_state(_), do: @initial_state

  def restore do
    {:ok, records} = Dynamo.get_records_since(Time.yesterday())
    %{ records: to_map(records), last_fetched: Time.now() }
  end

  def start do
    Agent.start(fn -> @initial_state end, name: __MODULE__)
  end

  def stop do
    Agent.stop(__MODULE__, :normal)
  end

  def truncate do
    Agent.cast(__MODULE__, fn (_)->  @initial_state end)
  end

  @spec get_records :: map
  def get_records do
    Agent.get(__MODULE__, fn (state) -> Map.values(state.records) end)
  end

  def get_all do
    Agent.get(__MODULE__, fn (state) ->
      records =
        state
        |> Map.get(:records)
        |> Map.values()

      %{records: records, last_fetched: state.last_fetched }
    end)
  end


  @spec filter_records(filtered_ids :: list(String.t)) :: :ok
  def filter_records(filtered_ids) do

    Agent.cast(__MODULE__,
      fn (state) ->
        %{state |
          records: Map.drop(state.records, filtered_ids)
         }
      end)
  end


  @spec put_records(to_add :: list(map), time :: String.t) :: :ok
  def put_records(to_add, last_fetched) do
    mapped_records =  to_map(to_add)

    Dynamo.put_records(to_add)

    Agent.cast(__MODULE__,
      fn (state) ->
        %{state |
          records: Map.merge(state.records, mapped_records),
          last_fetched: last_fetched
         }
      end)
  end


 @spec is_member?(record :: map) :: true | false
  def is_member?(%{id: id}) do

    Agent.get(__MODULE__,
      fn (state) ->
        Map.has_key?(state.records, id)
      end)
  end

  @spec to_map(list :: list) :: map
  defp to_map(list) do
    Enum.reduce(list, %{}, fn (item, acc) -> Map.put(acc, item.id, item) end)
  end
end

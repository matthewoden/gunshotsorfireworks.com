defmodule CallsForService.Dynamo do
  require Logger
  alias ExAws.Dynamo
  alias CallsForService.Config
  alias CallsForService.Scraper.ServiceRecord


  def put_records([]), do: []
  def put_records(list) do
    write_records(list, :put)
    list
  end

  def delete_records([]), do: []
  def delete_records(list) do
    write_records(list, :delete)
    list
  end

  defp create_put_request(item), do: [put_request: [item: item]]
  defp create_delete_request(item), do: [delete_request: [key: %{id: item.id, time: item.time}]]

  def write_records([], _), do: []
  def write_records(list, write_type) do
    list
    |> Stream.chunk(25, 25, [])
    |> Stream.map(&batch_write_records(&1, write_type))
    |> Enum.each(fn
      ({:error, reason }) ->
        Logger.error("Could not #{inspect write_type} records batch. Reason: #{inspect reason}")

      (otherwise) ->
        otherwise
    end)
  end

  def batch_write_records(list, write_type) do
    requests =
      case write_type do
        :put ->
          Enum.map(list, &create_put_request(&1))
        :delete ->
          Enum.map(list, &create_delete_request(&1))
      end

    table = Config.get_table_name()

    Map.new()
    |> Map.put(table, requests)
    |> Dynamo.batch_write_item()
    |> ExAws.request
  end

  def get_records_since(time) do
    get_records(
      expression_attribute_names: %{"#time" => "time"},
      expression_attribute_values: [time: time],
      filter_expression: "#time >= :time"
    )
  end

  def get_records_between(start_date, end_date) do
    get_records(
      expression_attribute_names: %{"#time" => "time"},
      expression_attribute_values: [start_date: start_date, end_date: end_date],
      filter_expression: "#time >= :start_date AND #time <= :end_date",
    )
  end

  # it seems like decode_items should handle this, and yet...
  def decode (item) do
    item
    |>Dynamo.Decoder.decode()
    |>Dynamo.Decoder.binary_map_to_struct(ServiceRecord)
    |>Map.update(:coordinates, %{}, fn (coords) ->
      %{ longitude: coords["longitude"], latitude: coords["latitude"]  }
    end)
  end

  def get_records(scan_options \\ []) do
    request =
      Config.get_table_name
      |>Dynamo.scan(scan_options)
      |>ExAws.request

    case request do
      {:ok, results } ->
        parsed =
          results
          |>Map.get("Items")
          |>Enum.map(&decode(&1))

        {:ok, parsed}

      {:error, reason} ->
        {:error, reason}

      otherwise ->
        {:error, otherwise}

    end
  end

end

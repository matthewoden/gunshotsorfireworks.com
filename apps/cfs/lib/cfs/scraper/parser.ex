defmodule CallsForService.Scraper.Parser do
  require Logger

  alias CallsForService.Scraper.ServiceRecord
  alias CallsForService.Time

  @type service_record :: %ServiceRecord{}
  @type parse_success :: {:ok, list(service_record) }
  @type parse_fail :: {:error, term}
  @type time_tuple :: {integer, integer, integer}


  @spec parse_html(html :: String.t) :: parse_success | parse_fail
  def parse_html(html) do
    try do
      records =
        html
        |> String.replace(~r/[\r\n]+/,"", global: true)
        |> Floki.find("tr")
        |> Stream.map(&parse_row/1)
        |> Stream.map(&to_record/1)
        |> Enum.filter(fn (item) -> item.gunshots or item.fireworks end)

      {:ok, records}
    rescue
      error ->
        Logger.debug("Unable to parse html. Reason: #{inspect error}")
        {:error, error}
    end
  end

  @spec parse_row({String.t, term, list}) :: list(String.t)
  defp parse_row({"tr", _, columns }) do
    extract_children(columns)
  end

  # recursively work through the html to get the actual text content of each
  # column element.

  @spec extract_children(list | tuple) :: list(String.t) | list(tuple) | tuple
  defp extract_children([content]) do
    extract_children(content)
  end

  defp extract_children(content) when is_list(content) do
    Enum.map(content, &extract_children/1)
  end

  defp extract_children({_,_, content }) do
     extract_children(content)
  end

  defp extract_children(content) do
     content
  end

  #################
  # Massage Data

  @spec format_location(location :: String.t) :: String.t
  defp format_location(location) do
    String.replace(location, "XX", "00", global: true)
  end

  @spec format_timestamp(timestamp_string :: String.t) :: String.t
  def format_timestamp(timestamp_string) do
    case attempt_timestamp_format(timestamp_string) do
      {:ok, formatted_time} ->
        formatted_time
      _ ->
        Time.now()
    end
  end

  @spec attempt_timestamp_format(timestamp :: String.t) :: {:ok, String.t} | {:error, term }
  defp attempt_timestamp_format(timestamp) do
    [date, time] = String.split(timestamp, " ", trim: true)

    date = split_and_parse_int(date, "-")
    time = split_and_parse_int(time, ":")

    Time.to_timestamp(date, time)
  end


  # grabs values from a string of "Year-Month-Day" or "Hour:Minute:Second"
  @spec split_and_parse_int(item :: String.t, split :: String.t) :: time_tuple
  defp split_and_parse_int(item, split) do
    [ first, second, third ] =
      item
      |> String.split(split, trim: true)
      |> Enum.map(&String.to_integer/1)

    { first, second, third }
  end


  #####
  # Types

  @spec is_fireworks?(type :: String.t) :: true | false
  def is_fireworks?(type) do
    Enum.member?(ServiceRecord.fireworks_events(), low_type(type))
  end

  @spec is_gunshots?(type :: String.t)  :: true | false
  def is_gunshots?(type) do
    Enum.member?(ServiceRecord.gunshots_events(), low_type(type))
  end

  @spec low_type(type :: String.t) :: String.t
  defp low_type(type), do: type |> String.downcase |> String.trim


  @spec to_record(list(String.t)) :: service_record
  defp to_record([ time, id, location, type ]) do
    %ServiceRecord{
      id: id,
      first_seen: Time.now(),
      time: format_timestamp(time),
      location: format_location(location),
      type: type,
      gunshots: is_gunshots?(type),
      fireworks: is_fireworks?(type),
      rating: ServiceRecord.event_rating(low_type(type))
    }
  end

end

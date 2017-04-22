defmodule CallsForService.Scraper do
  require Logger

  alias CallsForService.Scraper.Http
  alias CallsForService.Scraper.Parser
  alias CallsForService.Scraper.Geocode

  def get_calls_for_service do
    with {:ok, html_string} <- Http.get("http://www.slmpd.org/cfs.aspx"),
         {:ok, parsed } <- Parser.parse_html(html_string)
      do
        parsed
    else
      _otherwise -> []
    end
  end

  def get_coordinates(street) do
    case Geocode.geocode_address(street) do
      {:ok, coordinates} ->
        coordinates

      {:error, error} ->
        Logger.error("Could not geocode street. Details: #{inspect error}")
        nil

      error ->
        Logger.error("Could not geocode street. Details: #{inspect error}")
        nil
    end
  end

end

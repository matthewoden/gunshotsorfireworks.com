defmodule CallsForService.Scraper.Geocode do

  require Logger

  alias CallsForService.Scraper.Http

  @type coordinates :: %{ latitude: float, longitude: float }

  @spec geocode_address(street :: String.t) ::  {:ok, coordinates} | {:error, term }
  def geocode_address(location) when is_binary(location) do
    try do
      coordinates =
        location
        |> create_geocode_parameters
        |> create_geocode_url
        |> fetch_json
        |> map_results

      {:ok, coordinates}
    rescue
      error ->
        {:error, error }
    end
  end

  def geocode_address(invalid_value) do
    {:error, "invalid address: #{inspect invalid_value}" }
  end

  @spec create_geocode_url(parameters :: String.t) :: String.t
  defp create_geocode_url(parameters) do
    "https://maps.googleapis.com/maps/api/geocode/json?#{parameters}"
  end


  @spec create_geocode_parameters(location :: String.t) :: String.t
  defp create_geocode_parameters(location) do
    "address=#{String.replace(location, " ", "+")}&components=locality:St.+Louis"
  end


  @spec map_results({:ok, json_map :: map }) :: coordinates
  defp map_results({:ok, json_map}) do
    result =
      json_map
      |> Map.get("results")
      |> Enum.at(0)
      |> get_in(["geometry", "location"])

    %{ latitude: result["lat"], longitude: result["lng"] }
  end

  @spec fetch_json(url:: String.t) :: {:ok, map} | {:error, any }
  defp fetch_json(url) do

    case Http.get(url) do
      {:ok, data } ->
        Poison.decode(data)

      {:error, error} ->
        error

      otherwise ->
        otherwise
    end
  end
end

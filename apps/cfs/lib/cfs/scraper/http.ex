defmodule CallsForService.Scraper.Http do
  require Logger

  def get(url) do
    final_url = to_charlist(url)

    case :httpc.request(final_url) do
      {:ok, {_, _, data} } ->
        {:ok, to_string(data) }

      {:error, reason} ->
        Logger.error "httpc error - Could not fetch request. #{inspect reason}"
        {:error, reason}

      otherwise ->
        Logger.error "unknown error - Could not fetch request. #{inspect otherwise}"
        {:error, otherwise}

    end
  end

end

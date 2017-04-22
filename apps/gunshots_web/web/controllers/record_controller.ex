defmodule GunshotsWeb.RecordController do
  use GunshotsWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.json", CallsForService.get_recent()
  end
end

defmodule GunshotsUi.RecordController do
  use GunshotsUi.Web, :controller

  def index(conn, params) do

    records = case params["type"] do
      "all" ->
        CallsForService.get_all()
      _ ->
        CallsForService.get_recent()
    end

    render conn, "index.json", records
  end
end

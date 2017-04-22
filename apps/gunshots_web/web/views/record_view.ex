defmodule GunshotsWeb.RecordView do
  use GunshotsWeb.Web, :view

  def render("index.json", %{ records: records, last_fetched: last_fetched }) do
    %{ ok: true, records: records, last_fetched: last_fetched }
  end
end

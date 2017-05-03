defmodule GunshotsUi.PageController do
  use GunshotsUi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end

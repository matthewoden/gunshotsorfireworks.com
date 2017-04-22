defmodule GunshotsWeb.Router do
  use GunshotsWeb.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", GunshotsWeb do
    pipe_through :api # Use the default browser stack

    get "/records", RecordController, :index

  end

end

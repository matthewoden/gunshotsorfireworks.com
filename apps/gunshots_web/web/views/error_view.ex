defmodule GunshotsWeb.ErrorView do
  use GunshotsWeb.Web, :view

  def render("404.json", _assigns) do
    %{errors: %{message: "Not Found"}}
  end

  def render("403.json", _assigns) do
    %{errors: %{message: "Not Found"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{message: "Server Error"}}
  end

  def render(_other, _assigns) do
    %{errors: %{message: "Server Error"}}
  end

end

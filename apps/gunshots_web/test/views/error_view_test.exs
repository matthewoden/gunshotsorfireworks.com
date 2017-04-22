defmodule GunshotsWeb.ErrorViewTest do
  use GunshotsWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render_to_string(GunshotsWeb.ErrorView, "404.json", []) ==
            "{\"errors\":{\"message\":\"Not Found\"}}"
  end

  test "render 500.json" do
    assert render_to_string(GunshotsWeb.ErrorView, "500.json", []) ==
            "{\"errors\":{\"message\":\"Server Error\"}}"
  end

  test "render any other" do
    assert render_to_string(GunshotsWeb.ErrorView, "505.json", []) ==
            "{\"errors\":{\"message\":\"Server Error\"}}"
  end
end

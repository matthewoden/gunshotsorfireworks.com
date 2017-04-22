defmodule Cron.ConfigTest do
  use ExUnit.Case

  setup do
    Application.get_all_env(:cron)
    |> Enum.each(fn ({key, _}) -> Application.delete_env(:cron, key) end)
  end

  test "grabs all environment variables for cron, dedupes" do
    Application.put_env(:cron, :app_a, [%{name: :a}, %{name: :b}, %{name: :c}])
    Application.put_env(:cron, :app_b, [%{name: :d}, %{name: :e}, %{name: :a}])

    results = Cron.Config.get() |> Enum.map(fn (i)-> i.name end) |> Enum.sort
    assert results  == [:a, :b,:c, :d, :e]
  end

end

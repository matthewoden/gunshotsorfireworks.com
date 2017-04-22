defmodule Cron.Config do

  def get do
    :cron
    |> Application.get_all_env
    |> Keyword.values
    |> List.flatten
    |> Enum.uniq_by(fn (item) -> item.name end)
  end

end

defmodule CallsForService.Config do

  def get_table_name do
    :cfs
    |> Application.get_env(:dynamo)
    |> Keyword.get(:table_name)
  end

  def get_cache_policy do
   :cfs
   |> Application.get_env(:store)
   |> Keyword.get(:cache_policy)
  end

end

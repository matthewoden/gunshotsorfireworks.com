defmodule CallsForService.DynamoTest do
  use ExUnit.Case
  alias ExAws.Dynamo
  alias CallsForService.Scraper.ServiceRecord

  @gunshots [%ServiceRecord{
                coordinates: %{}, fireworks: false,
                first_seen: "2017-02-26T17:30:29.096047-06:00", gunshots: true,
                id: "P1702260769", location: "1900 SANCHEZ AVE",
                time: "2017-02-26T17:30:29.096047-06:00", type: "Shots Fired",
                rating: 0.5}]

  @old [%ServiceRecord{
           coordinates: %{}, fireworks: false,
           first_seen: "2017-02-26T17:30:29.096047-06:00", gunshots: true,
           id: "P1702260768", location: "1900 SANCHEZ AVE",
           time: "2017-02-20T17:30:29.096047-06:00", type: "Shots Fired",
           rating: 0.5}]


  setup do
    table = CallsForService.Config.get_table_name
    cleared =
      Dynamo.scan(table)
      |> ExAws.request!
      |> Map.get("Items")
      |> Stream.map(fn (item) -> CallsForService.Dynamo.decode(item) end)
      |> CallsForService.Dynamo.delete_records()
      |> Enum.to_list

    %{cleared: cleared}
  end


  test "puts/gets records in/from the table" do
    submitted = CallsForService.Dynamo.put_records(@gunshots)
    {:ok, found } = CallsForService.Dynamo.get_records([])

    assert submitted == found
  end

  test "gets records between dates" do
    records = Enum.concat(@gunshots, @old)
    start_date = "2017-02-19T17:30:29.096047-06:00"
    end_date = "2017-02-25T17:30:29.096047-06:00"

    CallsForService.Dynamo.put_records(records)
    {:ok, found} =
      CallsForService.Dynamo.get_records_between(start_date, end_date)

    assert found == @old
  end

  test "gets records after a certain date" do
    records = Enum.concat(@gunshots, @old)
    start_date = "2017-02-21T17:30:29.096047-06:00"

    CallsForService.Dynamo.put_records(records)
    {:ok, found} =
      CallsForService.Dynamo.get_records_since(start_date)

    assert found == @gunshots
  end

end

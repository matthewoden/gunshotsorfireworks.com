defmodule CallsForService.StoreTest do
  use ExUnit.Case

  alias CallsForService.Store
  alias CallsForService.Scraper.ServiceRecord

  @test_time CallsForService.Time.now()

  @record %ServiceRecord{coordinates: %{}, fireworks: false,
          first_seen: "2017-02-26T17:30:29.096047-06:00", gunshots: true,
          id: "P1702260768", location: "1900 LUCAS AVE",
          time: @test_time, type: "Shot Spotter", rating: 0.9}

  @old_record %ServiceRecord{coordinates: %{}, fireworks: false,
              first_seen: "2017-02-26T17:30:29.096047-06:00", gunshots: true,
              id: "P1702260769", location: "1900 SANCHEZ AVE",
              time: "2017-02-26T17:30:29.096047-06:00", type: "Shots Fired",
              rating: 0.5}

  setup do
    Store.stop()
    Store.start()
    :ok
  end

  test "initial state" do
    assert Store.get_records() == []
  end

  test "put records" do
    updates = [@record, @old_record]

    Store.put_records(updates, @test_time)
    assert Store.get_records() == updates
  end


  test "filter records" do
    updates = [@record, @old_record]

    Store.put_records(updates, @test_time)

    updates
    |> Enum.map(fn (item) -> item.id end)
    |> Store.filter_records()

    assert Store.get_records() == []
  end

  test "is member?" do
    Store.put_records([@record], @test_time)
    assert Store.is_member?(@old_record) == false
    assert Store.is_member?(@record) == true
  end


end

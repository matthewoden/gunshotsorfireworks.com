defmodule CallsForServiceTest do
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
    Store.put_records([@record, @old_record], @test_time)

    on_exit fn ->
      Store.truncate()
    end
  end

  test "fetches recent records from the cache" do

    %{records: records} = CallsForService.get_recent()

    assert records == [@record]
  end

  # test "scrapes and saves new records, adds geocodes" do
  #   # TODO: Maybe add a mock scraper. Sigh. 
  # end

  test "cleans up old records from the cache" do

    :ok = CallsForService.cleanup_expired()
    records = Store.get_records()

    assert records == [@record]
  end

end

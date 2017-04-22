defmodule GunshotsWeb.PageControllerTest do
  use GunshotsWeb.ConnCase

  alias CallsForService.Scraper.ServiceRecord
  alias CallsForService.Store

  @test_time CallsForService.Time.now()
  @record %ServiceRecord{coordinates: %{}, fireworks: false,
            first_seen: "2017-02-26T17:30:29.096047-06:00", gunshots: true,
            id: "P1702260768", location: "1900 LUCAS AVE",
            time: @test_time, type: "Shot Spotter", rating: 0.9}


  setup do
    Application.stop(:cfs)
    Application.start(:cfs)

    Store.put_records([@record], @test_time)
  end

  test "GET /v1/records", %{conn: conn} do

    conn = get conn, "/v1/records"
    assert json_response(conn, 200) == %{
      "ok" => true,
      "records" => [%{"coordinates" => %{}, "fireworks" => false,
                      "first_seen" => "2017-02-26T17:30:29.096047-06:00",
                      "gunshots" => true, "id" => "P1702260768",
                      "location" => "1900 LUCAS AVE", "rating" => 0.9,
                      "time" => @test_time, "type" => "Shot Spotter"}],
      "last_fetched" => @test_time
    }
  end
end


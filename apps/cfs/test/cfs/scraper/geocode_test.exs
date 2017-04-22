defmodule CallsForService.Scraper.GeocodeTest do
  use ExUnit.Case

  alias CallsForService.Scraper.Geocode

  test "geocodes a street name" do
     result = Geocode.geocode_address("1900 LUCAS AVE")

     assert result == {:ok, %{latitude: 38.6342305, longitude: -90.2062167} }
  end

  test "returns nil when given a bad value" do
     
     assert {:error, "invalid address: 321"} ==  Geocode.geocode_address(321)
  end

end

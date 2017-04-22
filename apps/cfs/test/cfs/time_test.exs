defmodule CallsForService.TimeTest do
  use ExUnit.Case

  alias CallsForService.Time

  test "checks if a timestamp happened yesterday (or earlier)" do
    now = Time.now()
    assert Time.happened_yesterday?(now) == false
    assert Time.happened_yesterday?("2017-02-26T17:30:29.096047-06:00") == true
    
  end

  test "checks if a timestamp happened within 15 minutes" do
    now = Time.now()
    assert Time.happened_recently?(now) == true
    assert Time.happened_recently?("2017-02-26T17:30:29.096047-06:00") == false
  end

  test "converts a {year, month, day} {hour, min sec} to ISO Chicago format" do
    formatted = { :ok, "2017-02-26T16:47:40-06:00" }
    date = { 2017, 2, 26 }
    time = { 16, 47, 40 }
    assert Time.to_timestamp(date, time) == formatted
  end

end

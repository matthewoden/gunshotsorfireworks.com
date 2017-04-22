defmodule CallsForService.Scraper.ParseTest do
  use ExUnit.Case

  alias CallsForService.Scraper.ServiceRecord
  alias CallsForService.Scraper.Parser

  @shots_fired "<tr style=\"color:Black;background-color:White;font-family:geneva,
                 arial,helvetica,sans-serif;;\">
                  <td>2017-02-26 16:47:40</td>
                  <td>P1702260768</td>
                  <td>19XX LUCAS AVE</td>
                  <td>Shot Spotter</td>
                  </tr>"

  @fireworks "<tr style=\"color:Black;background-color:White;font-family:geneva,
                arial,helvetica,sans-serif;;\">
                <td>2017-02-26 16:47:40</td>
                <td>P1702260768</td>
                <td>19XX LUCAS AVE</td>
                <td>Fireworks</td>
                </tr>"

  @not_fired "<tr style=\"color:Black;background-color:White;font-family:geneva,
              arial,helvetica,sans-serif;;\">
                  <td>2017-02-26 16:47:40</td>
                  <td>P1702260768</td>
                  <td>19XX LUCAS AVE</td>
                  <td>Disturbance</td>
              </tr>"

  test "grabs valid records" do
    {:ok, [%ServiceRecord{id: result}] } = Parser.parse_html(@shots_fired)

    assert result == "P1702260768"
  end

  test "formats XX in street names to be 00" do
    {:ok, [%ServiceRecord{location: location }] } = Parser.parse_html(@shots_fired)
    assert location == "1900 LUCAS AVE"
  end

  test "formats the timestamp to an ISO standard" do
    {:ok, [%ServiceRecord{time: time }] } = Parser.parse_html(@shots_fired)

    assert time == "2017-02-26T16:47:40-06:00"
  end

  test "marks the record as a gunshot when true" do
    {:ok, [record] } = Parser.parse_html(@shots_fired)
    %ServiceRecord{gunshots: is_gunshot, fireworks: is_fireworks} = record

    assert is_gunshot == true
    assert is_fireworks == false
  end

  test "marks the record as fireworks when true" do
    {:ok, [record] } = Parser.parse_html(@fireworks)
    %ServiceRecord{gunshots: is_gunshot, fireworks: is_fireworks} = record

    assert is_gunshot == false
    assert is_fireworks == true
  end

  test "ignores records that at not gunshots, or fireworks" do
    {:ok, result } = Parser.parse_html(@not_fired)

    assert result == []
  end

  test "assigns a rating to the event" do
    {:ok, [record] } = Parser.parse_html(@shots_fired)
    %ServiceRecord{rating: rating} = record
    assert rating == 0.9
  end

end

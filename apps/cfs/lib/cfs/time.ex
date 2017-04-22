defmodule CallsForService.Time do
  use Timex

  @type time_tuple :: {integer, integer, integer}

  @spec now :: String.t
  def now do
    {:ok, time } = Timex.format(Timex.now("America/Chicago"), "{ISO:Extended}")
    time
  end

  def yesterday do
    {:ok, time} =
      Timex.now("America/Chicago")
      |>Timex.shift(days: -1)
      |>Timex.format("{ISO:Extended}")

    time
  end

  @spec to_timestamp(time :: time_tuple, date :: time_tuple) :: String.t
  def to_timestamp({year, month, day}, {hour, minute, second}) do
    time_and_date = { {year, month, day}, {hour, minute, second} }

    Timex.to_datetime(time_and_date, "America/Chicago")
    |> Timex.format("{ISO:Extended}")
  end

  @spec happened_yesterday?(time :: String.t) :: true | false
  def happened_yesterday?(time) do
    {:ok, day_ago } = Timex.parse(yesterday(), "{ISO:Extended}")

    case Timex.parse(time, "{ISO:Extended}") do
      {:ok, parsed_time } ->
        Timex.before?(parsed_time, day_ago)

      _otherwise ->
        false
    end
  end

  @spec happened_recently?(time :: String.t) :: true | false
  def happened_recently?(time) do
    fifteen_minutes_ago = Timex.shift(Timex.now("America/Chicago"), minutes: -1)

    case Timex.parse(time, "{ISO:Extended}") do
      {:ok, parsed_time } ->
        Timex.before?(fifteen_minutes_ago, parsed_time)

      _otherwise ->
        false
    end
  end


end

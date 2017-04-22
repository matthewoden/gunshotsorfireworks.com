defmodule CallsForService.Scraper.ServiceRecord do
  require Logger

  @typedoc """
    Service Record - the meat of the project.
  """

  @type coordinates ::  %{latitude: String.t, longitude: String.t}
  @type t :: %__MODULE__{
             id: String.t,
             time: String.t,
             location: String.t, 
             type: String.t,
             coordinates: coordinates | nil,
             gunshots: true | false,
             fireworks: true | false,
             first_seen: String.t,
             rating: integer
            }

  @derive [ExAws.Dynamo.Encodable]
  defstruct  id: "",
             time: "",
             location: "",
             type: "",
             coordinates: nil,
             gunshots: false,
             fireworks: false,
             first_seen: "",
             rating: 0


  def event_rating (event) do
    case event do
      "shot spotter" -> 0.9
      "shooting" -> 0.8
      "shots fired" -> 0.5
      "shots fired - into dwelling" -> 0.6
      "shots fired - property damage" -> 0.6
      "new year's eve shots fired" -> 0.7
      "fireworks" -> 0.5
      "fireworks - july 4" -> 0.7
      _ -> 0
     end
  end

  def fireworks_events do
    [
      "fireworks",
      "fireworks - july 4"
    ]
  end

  def gunshots_events do
    [
      "shooting",
      "shots fired",
      "shots fired - into dwelling",
      "shots fired - property damage",
      "shot spotter",
      "new year's eve shots fired"
    ]
  end

end

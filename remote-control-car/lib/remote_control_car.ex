defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct battery_percentage: 100, distance_driven_in_meters: 0, nickname: nil

  def new(nickname \\ "none"), do: %RemoteControlCar{nickname: nickname}

  @spec display_distance(%RemoteControlCar{}) :: String.t()
  def display_distance(%RemoteControlCar{distance_driven_in_meters: miter}), do: "#{miter} meters"

  def display_battery(%RemoteControlCar{battery_percentage: 0}), do: "Battery empty"

  def display_battery(%RemoteControlCar{battery_percentage: battery_value}),
    do: "Battery at #{battery_value}%"

  def drive(remote_car = %RemoteControlCar{battery_percentage: 0}), do: remote_car

  def drive(
        remote_car = %RemoteControlCar{
          battery_percentage: battery,
          distance_driven_in_meters: distance
        }
      ),
      do: %{
        remote_car
        | battery_percentage: battery - 1,
          distance_driven_in_meters: distance + 20
      }
end

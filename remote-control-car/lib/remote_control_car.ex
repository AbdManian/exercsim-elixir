defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct battery_percentage: 100, distance_driven_in_meters: 0, nickname: nil

  def new(nickname \\ "none"), do: %__MODULE__{nickname: nickname}

  def display_distance(%__MODULE__{distance_driven_in_meters: miter}), do: "#{miter} meters"

  def display_battery(%__MODULE__{battery_percentage: 0}), do: "Battery empty"

  def display_battery(%__MODULE__{battery_percentage: battery_value}),
    do: "Battery at #{battery_value}%"

  def drive(remote_car = %__MODULE__{battery_percentage: 0}), do: remote_car

  def drive(
        remote_car = %__MODULE__{
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

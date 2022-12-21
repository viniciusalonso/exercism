defmodule RemoteControlCar do
  @enforce_keys [:nickname]

  defstruct battery_percentage: 100,
            distance_driven_in_meters: 0,
            nickname: nil

  def new(nickname \\ "none")

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance_driven_in_meters}) do
    "#{distance_driven_in_meters} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar{battery_percentage: battery_percentage}) do
    "Battery at #{battery_percentage}%"
  end

  def drive(%RemoteControlCar{
        battery_percentage: 0,
        distance_driven_in_meters: distance_driven_in_meters,
        nickname: nickname
      }) do
    %RemoteControlCar{
      battery_percentage: 0,
      distance_driven_in_meters: distance_driven_in_meters,
      nickname: nickname
    }
  end

  def drive(%RemoteControlCar{
        battery_percentage: battery_percentage,
        distance_driven_in_meters: distance_driven_in_meters,
        nickname: nickname
      }) do
    %RemoteControlCar{
      battery_percentage: battery_percentage - 1,
      distance_driven_in_meters: distance_driven_in_meters + 20,
      nickname: nickname
    }
  end
end

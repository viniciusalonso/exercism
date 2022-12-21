defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) when number == 1 do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end

  def verse(number) when number == 0 do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{number} #{bottles(number)} of beer on the wall, #{number} #{bottles(number)} of beer.
    Take one down and pass it around, #{number - 1} #{bottles(number - 1)} of beer on the wall.
    """
  end

  defp bottles(1), do: "bottle"

  defp bottles(_number), do: "bottles"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0)

  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end
end

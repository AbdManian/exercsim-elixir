defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()

  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{x_bottle(number)} of beer on the wall, #{x_bottle(number)} of beer.
    Take #{x_adj(number)} down and pass it around, #{x_bottle(number - 1)} of beer on the wall.
    """
  end

  defp x_bottle(1), do: "1 bottle"
  defp x_bottle(0), do: "no more bottles"
  defp x_bottle(x), do: "#{x} bottles"

  defp x_adj(1), do: "it"
  defp x_adj(_), do: "one"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    range
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  def lyrics(), do: lyrics(99..0)
end

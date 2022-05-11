defmodule ResistorColorTrio do
  @color_table %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  defp pow10(color) when is_atom(color), do: pow10(@color_table[color])
  defp pow10(0), do: 1
  defp pow10(x), do: 10 * pow10(x - 1)

  defp resistor(value) when value >= 1000, do: {div(value, 1000), :kiloohms}
  defp resistor(value), do: {value, :ohms}

  @doc """
  Calculate the resistance value in ohm or kiloohm from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms}
  def label([color1, color2, color3]) do
    ((@color_table[color1] * 10 + @color_table[color2]) * pow10(@color_table[color3]))
    |> resistor()
  end
end

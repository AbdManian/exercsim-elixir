defmodule ResistorColorDuo do
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

  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer

  def value([first, second | _]) do
    @color_table[first] * 10 + @color_table[second]
  end
end

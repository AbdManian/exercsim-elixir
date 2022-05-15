defmodule WineCellar do
  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red: "Fermented with skin contact using dark-colored grapes.",
      rose: "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, opts \\ []),
    do:
      Enum.reduce(
        opts,
        Keyword.get_values(cellar, color),
        &selector(&2, &1)
      )

  defp selector(wines, {:year, year}), do: wines |> Enum.filter(fn {_, y, _} -> y == year end)

  defp selector(wines, {:country, country}),
    do: wines |> Enum.filter(fn {_, _, c} -> c == country end)

  defp selector(wines, []), do: wines
end

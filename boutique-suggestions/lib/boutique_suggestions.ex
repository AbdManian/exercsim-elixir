defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100.0)

    for a <- tops,
        b <- bottoms,
        a.base_color != b.base_color,
        a.price + b.price < max_price do
      {a, b}
    end
  end
end

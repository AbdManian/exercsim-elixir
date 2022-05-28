defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..(limit - 1)
    |> Enum.filter(&mul_of_factors(&1, factors))
    |> Enum.sum()
  end

  defp mul_of_factors(_, []), do: false
  defp mul_of_factors(value, [f | _]) when rem(value, f) == 0, do: true
  defp mul_of_factors(value, [_ | rest]), do: mul_of_factors(value, rest)
end

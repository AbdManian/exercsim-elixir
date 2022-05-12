defmodule SquareRoot do
  @doc """
  Calculate the integer square root of a positive integer
  """
  @spec calculate(radicand :: pos_integer) :: pos_integer
  def calculate(radicand) do
    calculate(1, radicand, radicand)
  end

  defp calculate(s, e, r) do
    mid = div(s+e, 2)
    cond do
      s*s == r -> s
      e*e == r -> e
      s >= e -> nil
      mid*mid >= r -> calculate(s, mid, r)
      true -> calculate(mid+1, e, r)
    end
  end
end

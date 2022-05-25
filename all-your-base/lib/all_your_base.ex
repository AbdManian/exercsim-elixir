defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    if Enum.all?(digits, &(&1 >= 0 and &1 < input_base)) do
      digits
      |> Enum.reduce(0, &(&1 + &2 * input_base))
      |> Stream.unfold(fn
        0 -> nil
        n -> {rem(n, output_base), div(n, output_base)}
      end)
      |> Enum.reverse()
      |> case do
        [] -> {:ok, [0]}
        result -> {:ok, result}
      end
    else
      {:error, "all digits must be >= 0 and < input base"}
    end
  end
end

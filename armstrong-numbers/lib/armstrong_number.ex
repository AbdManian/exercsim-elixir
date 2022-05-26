defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits =
      number
      |> Stream.unfold(fn
        0 -> nil
        n -> {rem(n, 10), div(n, 10)}
      end)
      |> Enum.to_list()

    digits
    |> Enum.map(fn x -> :math.pow(x, length(digits)) |> round() end)
    |> Enum.sum() == number
  end
end

defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number >= 1 do
    sum = aliquot_sum(number)

    cond do
      sum == number and number != 1 -> {:ok, :perfect}
      sum > number -> {:ok, :abundant}
      true -> {:ok, :deficient}
    end
  end

  def classify(_), do: {:error, "Classification is only possible for natural numbers."}

  def aliquot_sum(1), do: 1

  def aliquot_sum(number) do
    1..div(number, 2)
    |> Enum.filter(&(rem(number, &1) == 0))
    |> Enum.sum()
  end
end

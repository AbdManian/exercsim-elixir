defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare(a, a), do: :equal

  def compare(a, b) do
    if length(a) > length(b) do
      if contains?(a, b) do
        :superlist
      else
        :unequal
      end
    else
      if contains?(b, a) do
        :sublist
      else
        :unequal
      end
    end
  end

  defp contains?(a, b) when length(a) < length(b), do: false

  defp contains?(a, a), do: true

  defp contains?(a, b) when length(a) == length(b), do: false

  defp contains?(a, b) do
    if a |> Enum.slice(0, length(b)) |> contains?(b) do
      true
    else
      [_ | rest] = a

      contains?(rest, b)
    end
  end
end

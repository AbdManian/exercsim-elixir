defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite([]), do: ""

  def recite(strings) do
    (strings
     |> Enum.chunk_every(2, 1, :discard)
     |> Enum.map(&proverb/1)
     |> Enum.join()) <>
      proverb(Enum.at(strings, 0))
  end

  defp proverb([word1, word2] = x) when is_list(x),
    do: "For want of a #{word1} the #{word2} was lost.\n"

  defp proverb(word), do: "And all for the want of a #{word}.\n"
end

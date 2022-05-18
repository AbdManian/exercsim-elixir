defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&anagram?(base, &1))
  end

  defp anagram?(base, word) do
    base = String.upcase(base)
    word = String.upcase(word)

    if base == word do
      false
    else
      base |> String.codepoints() |> Enum.sort() ==
        word |> String.codepoints() |> Enum.sort()
    end
  end
end

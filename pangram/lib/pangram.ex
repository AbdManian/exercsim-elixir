defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.downcase()
    |> String.codepoints()
    |> Enum.reduce_while(get_char_map(), &check_char/2) === %{}
  end

  defp check_char(char, char_map) do
    if char_map === %{} do
      {:halt, char_map}
    else
      {:cont, char_map |> Map.delete(char)}
    end
  end

  defp get_char_map() do
    "abcdefghijklmnopqrstuvwxyz"
    |> String.codepoints()
    |> Enum.into(%{}, &{&1, true})
  end
end

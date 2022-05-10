defmodule Bob do
  defp all_caps?(input) do
    input == String.upcase(input) and input != String.downcase(input)
  end

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)
    cond do
      all_caps?(input) and String.ends_with?(input, "?") -> "Calm down, I know what I'm doing!"
      String.ends_with?(input, "?") -> "Sure."
      all_caps?(input) -> "Whoa, chill out!"
      input == "" -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end

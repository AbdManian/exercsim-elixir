defmodule Bob do
  defp is_all_caps(input) do
    input == String.upcase(input) and input =~ ~r/\p{Lu}/
  end

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      is_all_caps(input) and String.ends_with?(input, "?") -> "Calm down, I know what I'm doing!"
      input |> String.trim() |> String.ends_with?("?") -> "Sure."
      is_all_caps(input) -> "Whoa, chill out!"
      String.trim(input) == "" -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end
end

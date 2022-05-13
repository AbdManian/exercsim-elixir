defmodule Username do
  def sanitize(username) do
    username
    |> Enum.map(&char_translate/1)
    |> Enum.concat()
  end

  @german_chars %{
    ?ä => 'ae',
    ?ö => 'oe',
    ?ü => 'ue',
    ?ß => 'ss'
  }

  def char_translate(code) do
    cond do
      code == ?_ -> '_'
      code >= ?a and code <= ?z -> [code]
      code in Map.keys(@german_chars) -> @german_chars[code]
      true -> []
    end
  end
end

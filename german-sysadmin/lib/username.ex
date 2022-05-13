defmodule Username do
  def sanitize(username) do
    Enum.reduce(username, '', fn x, acc ->
      # IO.puts "Value x #{x} and acc = #{acc}"
      acc ++
        case x do
          ?_ -> '_'
          ?ä -> 'ae'
          ?ö -> 'oe'
          ?ü -> 'ue'
          ?ß -> 'ss'
          x when x in ?a..?z -> [x]
          _ -> ''
        end
    end)
  end
end

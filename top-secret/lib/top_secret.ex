defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part(ast = {func, _, body}, acc) when func in [:def, :defp] do
    {ast, [get_name(body) | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  defp func_name_cipher(_, nil), do: ""

  defp func_name_cipher(f_atom, args),
    do: f_atom |> Atom.to_string() |> String.slice(0, length(args))

  defp get_name([{:when, _, [f_dec | _]} | _]), do: get_name([f_dec])
  defp get_name([{fname, _, args} | _]), do: func_name_cipher(fname, args)

  defp decoder({x, _, body}, acc)  when x in [:def, :defp] do
    {_, names} = decode_secret_message_part({:def, [], body}, [])
    acc <> Enum.join(names)
  end

  defp decoder({_, _, body}, acc), do: decoder(body, acc)

  defp decoder([], acc), do: acc

  defp decoder([h | rest], acc), do: decoder(h, acc) <> decoder(rest, "")

  defp decoder({:do, body}, acc), do: decoder(body, acc)

  defp decoder(_, acc), do: acc

  def decode_secret_message(string) do
    string |> to_ast() |> decoder("")
  end
end

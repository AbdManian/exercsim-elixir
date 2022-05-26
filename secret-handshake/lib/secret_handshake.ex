defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  # Refactored based on Cohen-Carlisle's solution

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> do_rule(code &&& 0b1000, "jump")
    |> do_rule(code &&& 0b0100, "close your eyes")
    |> do_rule(code &&& 0b0010, "double blink")
    |> do_rule(code &&& 0b0001, "wink")
    |> do_rule(code &&& 0b10000, &Enum.reverse/1)
  end

  defp do_rule(acc, mask_result, operation)
  defp do_rule(acc, 0, _), do: acc
  defp do_rule(acc, _, str) when is_binary(str), do: [str | acc]
  defp do_rule(acc, _, op), do: op.(acc)
end

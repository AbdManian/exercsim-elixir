defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer

  def nth(count) when count < 1, do: raise(ArgumentError)

  def nth(count) do
    do_nth([2, 3], count)
    |> List.last()
  end

  defp do_nth(_, 1), do: [2]

  defp do_nth(primes, count) when length(primes) == count, do: primes

  defp do_nth(primes, count) do
    start = List.last(primes)

    next_prime(primes, start + 2)
    |> do_nth(count)
  end

  defp next_prime(prime_list, n) do
    if isprime(prime_list, n) do
      prime_list ++ [n]
    else
      next_prime(prime_list, n + 2)
    end
  end

  defp isprime([], _), do: true
  defp isprime([p | _], val) when rem(val, p) == 0, do: false
  defp isprime([_ | other], val), do: isprime(other, val)
end

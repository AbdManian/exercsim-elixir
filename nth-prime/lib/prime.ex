defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
  end


  def do_nth(primes, count) do
    cond do
      length(primes) == count -> primes
      _ -> do_nth(next_prime(primes), )
    end
  end

  when length(primes) == count, do: primes


  def next_prime(prime_list, n) do
    if isprime(prime_list, n) do
      prime_list ++ [n]
    else
      next_prime(prime_list, n + 2)
    end
  end

  defp isprime([], _), do: true
  defp isprime([p|_], val) when rem(val, p) == 0, do: false
  defp isprime([_|other], val), do: isprime(other, val)



end

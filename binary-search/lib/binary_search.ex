defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    binary_search(numbers, 0, tuple_size(numbers) - 1, key)
  end

  defp binary_search({}, _, _, _), do: :not_found

  defp binary_search(numbers, start_index, end_index, key)
       when start_index == end_index or start_index + 1 == end_index do
    cond do
      elem(numbers, start_index) == key -> {:ok, start_index}
      elem(numbers, end_index) == key -> {:ok, end_index}
      true -> :not_found
    end
  end

  defp binary_search(numbers, start_index, end_index, key) do
    mid = div(start_index + end_index, 2)
    mid_val = elem(numbers, mid)

    cond do
      mid_val == key -> {:ok, mid}
      mid_val > key -> binary_search(numbers, start_index, mid, key)
      true -> binary_search(numbers, mid, end_index, key)
    end
  end
end

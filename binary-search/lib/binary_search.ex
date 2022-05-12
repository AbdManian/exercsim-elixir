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

  defp binary_search(_, start_index, end_index, _)
       when end_index < start_index,
       do: :not_found

  defp binary_search(numbers, start_index, end_index, key) do
    mid = div(start_index + end_index, 2)
    mid_val = elem(numbers, mid)

    cond do
      mid_val == key -> {:ok, mid}
      mid_val > key -> binary_search(numbers, start_index, mid - 1, key)
      true -> binary_search(numbers, mid + 1, end_index, key)
    end
  end
end

defmodule ETL do
  @doc """
  Transforms an old Scrabble score system to a new one.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn
      {k, v}, acc -> put_array_in_map(v, k, acc)
    end)
  end

  @spec put_array_in_map(any, any, any) :: any
  def put_array_in_map(data_list, key, map) do
    data_list
    |> Enum.map(&String.downcase/1)
    |> Enum.reduce(map, fn x, acc -> Map.put(acc, x, key) end)
  end
end

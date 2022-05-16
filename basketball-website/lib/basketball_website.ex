defmodule BasketballWebsite do
  def extract_from_path(data, path), do: get_in_path(data, path)

  defp extract_access([], data), do: data

  defp extract_access([x | rest], data), do: extract_access(rest, data[x])

  def get_in_path(data, path) do
    path
    |> String.split(".")
    |> extract_access(data)
  end
end

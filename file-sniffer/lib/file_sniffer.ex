defmodule FileSniffer do
  @file_types %{
    "exe" => "application/octet-stream",
    "bmp" => "image/bmp",
    "png" => "image/png",
    "jpg" => "image/jpg",
    "gif" => "image/gif"
  }

  @file_magic %{
    "exe" => <<0x7F, 0x45, 0x4C, 0x46>>,
    "bmp" => <<0x42, 0x4D>>,
    "png" => <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>,
    "jpg" => <<0xFF, 0xD8, 0xFF>>,
    "gif" => <<0x47, 0x49, 0x46>>
  }

  def type_from_extension(extension), do: @file_types[extension]

  defp ext_from_binary(file_binary) do
    {ext, _} =
      Enum.find(@file_magic, fn {_, pattern} -> String.starts_with?(file_binary, pattern) end)

    ext
  end

  @spec type_from_binary(any) :: nil
  def type_from_binary(file_binary) do
    ext_from_binary(file_binary) |> type_from_extension()
  end

  def verify(file_binary, extension) do
    case ext_from_binary(file_binary) do
      ^extension -> {:ok, type_from_extension(extension)}
      _ -> {:error, "Warning, file format and file extension do not match."}
    end
  end
end

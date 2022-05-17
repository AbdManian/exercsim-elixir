defmodule FileSniffer do
  @file_types %{
    "exe" => {"application/octet-stream", <<0x7F, 0x45, 0x4C, 0x46>>},
    "bmp" => {"image/bmp", <<0x42, 0x4D>>},
    "png" => {"image/png", <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>},
    "jpg" => {"image/jpg", <<0xFF, 0xD8, 0xFF>>},
    "gif" => {"image/gif", <<0x47, 0x49, 0x46>>}
  }

  def type_from_extension(extension) do
    {type, _} = @file_types[extension]
    type
  end

  defp ext_from_binary(file_binary) do
    {ext, _} =
      Enum.find(@file_types, fn {_, {_, pattern}} -> String.starts_with?(file_binary, pattern) end)

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

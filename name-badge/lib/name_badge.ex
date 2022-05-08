defmodule NameBadge do

  defp dep_name(nil), do: "OWNER"
  defp dep_name(name), do: String.upcase(name)

  defp id_str(nil), do: ""
  defp id_str(id), do: "[#{id}] - "


  def print(id, name, department) do
    "#{id_str(id)}#{name} - #{dep_name(department)}"
  end
end

defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: @planetary_classes |> Enum.random()

  def random_ship_registry_number(), do: "NCC-#{Enum.random(1000..9999)}"

  def random_stardate(), do: 41000.0 + 1000.0 * :rand.uniform()

  def format_stardate(stardate) when is_float(stardate),
    do: :io_lib.format("~.1f", [stardate]) |> List.to_string()

  def format_stardate(_), do: raise(ArgumentError, "Grefti ma ro?")
end

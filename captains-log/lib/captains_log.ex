defmodule CaptainsLog do
  @planetary_classes ["D", "H", "J", "K", "L", "M", "N", "R", "T", "Y"]

  def random_planet_class(), do: @planetary_classes |> Enum.random()

  def random_ship_registry_number(), do: "NCC-#{999 + :rand.uniform(9000)}"

  def random_stardate(), do: 41000.0 + 1000.0 * :rand.uniform()

  def format_stardate(stardate) when is_float(stardate), do: "#{round(stardate * 10) / 10.0}"

  def format_stardate(_), do: raise(ArgumentError, "Grefti ma ro?")
end

defmodule KitchenCalculator do
  defp unit_ml(label) do
    case label do
      :cup -> 240.0
      :fluid_ounce -> 30.0
      :teaspoon -> 5
      :tablespoon -> 15
      :milliliter -> 1
    end
  end

  def get_volume({_, value}) do
    value
  end

  def to_milliliter({unit, value}) do
    {:milliliter, value * unit_ml(unit)}
  end

  def from_milliliter({base, value}, unit) do
    {:milliliter, ml_val} = to_milliliter({base, value})
    {unit, ml_val / unit_ml(unit)}
  end

  def convert(volume_pair, unit) do
    from_milliliter(volume_pair, unit)
  end
end

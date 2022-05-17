defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    inventory
    |> Enum.sort_by(& &1.price)
  end

  def with_missing_price(inventory) do
    inventory
    |> Enum.filter(&(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(&update_in(&1[:name], fn x -> String.replace(x, old_word, new_word) end))
  end

  def increase_quantity(item, count) do
    qlist = item[:quantity_by_size]
    %{item | quantity_by_size: Enum.into(qlist, %{}, fn {k, v} -> {k, v + count} end)}
  end

  def total_quantity(item) do
    item.quantity_by_size
    |> Enum.reduce(0, fn {_, c}, acc -> c + acc end)
  end
end

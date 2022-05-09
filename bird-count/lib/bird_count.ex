defmodule BirdCount do
  def today([]), do: nil

  def today([first_day | _]), do: first_day

  def increment_day_count([]), do: [1]
  def increment_day_count([first_day | other_days]), do: [first_day + 1 | other_days]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | other]), do: has_day_without_birds?(other)

  def total([]), do: 0
  def total([d | list]), do: d + total(list)

  def busy_days([]), do: 0
  def busy_days([d | other]) when d >= 5, do: 1 + busy_days(other)
  def busy_days([_ | other]), do: busy_days(other)
end

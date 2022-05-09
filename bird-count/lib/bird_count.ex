defmodule BirdCount do
  def today([]), do: nil

  def today([first_day | _]), do: first_day

  def increment_day_count([]), do: [1]
  def increment_day_count([first_day | other_days]), do: [first_day + 1 | other_days]

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([0 | _]), do: true
  def has_day_without_birds?([_ | other]), do: has_day_without_birds?(other)

  def total(list, cnt \\ 0)
  def total([], cnt), do: cnt
  def total([d | other], cnt), do: total(other, cnt + d)

  def busy_days(list, cnt \\ 0) do
    case list do
      [] -> cnt
      [d | other] when d >= 5 -> busy_days(other, cnt + 1)
      [_ | other] -> busy_days(other, cnt)
    end
  end
end

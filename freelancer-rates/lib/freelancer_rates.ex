defmodule FreelancerRates do
  @hour_per_day 8.0
  @day_in_month 22

  def daily_rate(hourly_rate) do
    hourly_rate * @hour_per_day
  end

  def apply_discount(before_discount, discount) do
    percent = 1.0 - discount / 100.0
    before_discount * percent
  end

  def monthly_rate(hourly_rate, discount) do
    (@day_in_month * @hour_per_day * hourly_rate)
    |> apply_discount(discount)
    |> ceil
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily = apply_discount(@hour_per_day * hourly_rate, discount)

    Float.floor(budget / daily, 1)
  end
end

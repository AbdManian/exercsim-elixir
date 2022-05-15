defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    return_days = if(before_noon?(checkout_datetime), do: 28, else: 29)

    NaiveDateTime.to_date(checkout_datetime)
    |> Date.add(return_days)
  end

  def days_late(planned_return_date, actual_return_datetime) do
    day_diff = Date.diff(actual_return_datetime, planned_return_date)

    if day_diff <= 0 do
      0
    else
      day_diff
    end
  end

  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return = return |> datetime_from_string

    monday_offer = if monday?(return), do: 2, else: 1

    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return)
    |> Kernel.*(rate)
    |> Kernel.div(monday_offer)
  end
end

defmodule DateParser do
  @spec day :: <<_::216>>
  def day(), do: "^(0?[1-9]|[12][0-9]|3[01])$"

  def month(), do: "^(0?[1-9]|1[0-2])$"

  def year(), do: "[0-9]{4}"

  def day_names(), do: ~S"(Monday|Tuesday|Sunday|Wednesday|Thursday|Friday|Saturday)"

  def month_names(),
    do:
      ~S"(January|February|March|April|May|June|July|August|September|October|November|December)"

  def capture_day(), do: "(?<day>0?[1-9]|[12][0-9]|3[01])"

  def capture_month(), do: "(?<month>0?[1-9]|1[0-2])"

  def capture_year(), do: "(?<year>[0-9]{4})"

  def capture_day_name(),
    do: ~S"\s*(?<day_name>Monday|Tuesday|Sunday|Wednesday|Thursday|Friday|Saturday)\s*"

  def capture_month_name(),
    do:
      ~S"\s*(?<month_name>January|February|March|April|May|June|July|August|September|October|November|December)\s*"

  def capture_numeric_date(),
    do: ~S"(?<day>0[1-9]|[12][0-9]|3[01])/(?<month>0[1-9]|1[0-2])/(?<year>[0-9]{4})"

  def capture_month_name_date() do
    "#{capture_month_name()} #{capture_day()}, #{capture_year()}"
  end

  def capture_day_month_name_date() do
    "#{capture_day_name()}, #{capture_month_name_date()}"
  end

  defp narrow_regex_build(func) do
    Regex.compile!("^#{func.()}$")
  end

  def match_numeric_date() do
    narrow_regex_build(&capture_numeric_date/0)
  end

  def match_month_name_date() do
    narrow_regex_build(&capture_month_name_date/0)
  end

  def match_day_month_name_date() do
    narrow_regex_build(&capture_day_month_name_date/0)
  end
end

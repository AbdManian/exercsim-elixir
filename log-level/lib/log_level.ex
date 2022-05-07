defmodule LogLevel do
  def legacy_check(:trace, true), do: :unknown
  def legacy_check(:fatal, true), do: :unknown
  def legacy_check(label, _), do: label

  def to_label(level, legacy?) do
    case level do
      0 -> :trace
      1 -> :debug
      2 -> :info
      3 -> :warning
      4 -> :error
      5 -> :fatal
      _ -> :unknown
    end
    |> legacy_check(legacy?)
  end

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label == :fatal or label == :error -> :ops
      label == :unknown and legacy? -> :dev1
      label == :unknown -> :dev2
      true -> false
    end
  end
end

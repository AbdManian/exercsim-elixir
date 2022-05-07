defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    tl(list)
  end

  def first(list) do
    hd(list)
  end

  def count([]), do: 0

  def count(list) do
    1 + (list |> remove |> count)
  end

  def functional_list?([]), do: false

  def functional_list?([lang | list]) do
    if lang === "Elixir" do
      true
    else
      functional_list?(list)
    end
  end
end

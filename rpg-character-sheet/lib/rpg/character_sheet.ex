defmodule RPG.CharacterSheet do
  def welcome() do
    IO.puts("Welcome! Let's fill out your character sheet together.")
  end

  defp get_user_input(message) do
    IO.gets(message) |> String.trim()
  end

  def ask_name() do
    get_user_input("What is your character's name?\n")
  end

  def ask_class() do
    get_user_input("What is your character's class?\n")
  end

  def ask_level() do
    get_user_input("What is your character's level?\n")
    |> String.to_integer()
  end

  def run() do
    welcome()

    %{
      name: ask_name(),
      class: ask_class(),
      level: ask_level()
    }
    |> IO.inspect(label: "Your character")
  end
end

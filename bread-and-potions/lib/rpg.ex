defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    @bread_health_inc 5
    def eat(_item, character) do
      {nil, %Character{character | health: character.health + @bread_health_inc}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(%ManaPotion{strength: mana_value}, char) do
      {
        %EmptyBottle{},
        Map.update(char, :mana, mana_value, &(&1 + mana_value))
      }
    end
  end

  defimpl Edible, for: Poison do
    def eat(_, char) do
      {
        %EmptyBottle{},
        %Character{char | health: 0}
      }
    end
  end
end

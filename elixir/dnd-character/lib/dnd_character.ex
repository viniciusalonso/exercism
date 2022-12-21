defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    ((score - 10) / 2)
    |> Float.floor()
    |> trunc
  end

  @spec ability :: pos_integer()
  def ability do
    random = [Enum.random(1..6), Enum.random(1..6), Enum.random(1..6), Enum.random(1..6)]
    min = Enum.min(random)

    result =
      Enum.reject(random, &(&1 == min))
      |> Enum.sum()

    if result < 3, do: ability(), else: result
  end

  @spec character :: t()
  def character do
    constitution = ability()

    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: constitution,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: modifier(constitution) + 10
    }
  end
end

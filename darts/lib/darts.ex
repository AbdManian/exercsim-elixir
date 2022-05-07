defmodule Darts do
  @type position :: {number, number}

  def _distance({x, y}), do: :math.sqrt(x * x + y * y)

  def _distance_to_score(distance) do
    cond do
      distance <= 1.0 -> 10
      distance <= 5.0 -> 5
      distance <= 10.0 -> 1
      distance > 10.0 -> 0
    end
  end

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    {x,y} |> _distance |> _distance_to_score
  end
end

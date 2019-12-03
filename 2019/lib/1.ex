defmodule Adventofcode.RocketEquation do

  import Adventofcode.Utils

  @doc """
  iex> Adventofcode.RocketEquation.part1()
  :ok
  """
  def part1 do
    get_input_stream(1, 1)
    |> Stream.map(& calculate_fuel(String.to_integer(&1)))
    |> Enum.sum
    |> IO.puts

    :ok
  end

  @doc """
  iex> Adventofcode.RocketEquation.calculate_fuel(12)
  2
  iex> Adventofcode.RocketEquation.calculate_fuel(14)
  2
  iex> Adventofcode.RocketEquation.calculate_fuel(1969)
  654
  iex> Adventofcode.RocketEquation.calculate_fuel(100756)
  33583
  """
  def calculate_fuel(mass) do
    trunc(mass / 3) - 2
  end
end

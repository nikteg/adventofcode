defmodule Adventofcode.RocketEquation do
  def solution(stream, part \\ 1)

  def solution(stream, 1) do
    stream
    |> Stream.map(& calculate_fuel(String.to_integer(&1)))
    |> Enum.sum
  end

  def solution(stream, 2) do
    stream
    |> Stream.map(& calculate_fuel2(String.to_integer(&1)))
    |> Enum.sum
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

  @doc """
  iex> Adventofcode.RocketEquation.calculate_fuel2(14)
  2
  iex> Adventofcode.RocketEquation.calculate_fuel2(1969)
  966
  iex> Adventofcode.RocketEquation.calculate_fuel2(100756)
  50346
  """
  def calculate_fuel2(mass, sum \\ 0)
  def calculate_fuel2(mass, sum) do
    case calculate_fuel(mass) do
      fuel when fuel > 0 -> calculate_fuel2(fuel, sum + fuel)
      _ -> sum
    end
  end
end

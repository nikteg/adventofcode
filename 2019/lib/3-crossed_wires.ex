defmodule Adventofcode.CrossedWires do
  def solution(stream, part \\ 1)

  def solution(stream, 1) do
    # stream
    # |> Stream.map(& (&1 |> string_to_program |> setup_io(12, 2) |> run |> program_to_string))
    # |> Enum.join()
  end

  def solution(stream, 2) do
    # stream
    # |> Stream.map(& (&1 |> string_to_program |> determine_inputs))
    # |> Enum.join()
  end

  @doc """
  iex> Adventofcode.ProgramAlarm.run([1,0,0,0,99])
  [2,0,0,0,99]
  iex> Adventofcode.ProgramAlarm.run([2,3,0,3,99])
  [2,3,0,6,99]
  iex> Adventofcode.ProgramAlarm.run([2,4,4,5,99,0])
  [2,4,4,5,99,9801]
  iex> Adventofcode.ProgramAlarm.run([1,1,1,4,99,5,6,0,99])
  [30,1,1,4,2,5,6,0,99]
  """
  def run(grid, [wire_a, wire_b) do
    case Enum.take(Enum.drop(program, cursor), 4) do
      [1, a, b, pos] -> run(List.update_at(program, pos, fn _ -> Enum.at(program, a) + Enum.at(program, b) end), cursor + 4)
      [2, a, b, pos] -> run(List.update_at(program, pos, fn _ -> Enum.at(program, a) * Enum.at(program, b) end), cursor + 4)
      [99 | _] -> program
    end
  end

  defp parse_path("U" <> distance), do: {:up,    String.to_integer(distance)}
  defp parse_path("D" <> distance), do: {:down,  String.to_integer(distance)}
  defp parse_path("L" <> distance), do: {:left,  String.to_integer(distance)}
  defp parse_path("R" <> distance), do: {:right, String.to_integer(distance)}

  defp update_grid(grid, origin, {direction, distance}) do
    for d <- 1..distance, do: Map.update(grid, determine_key(origin, {direction, d}), 0, &(&1 + 1))
  end

  defp determine_key({x, y}, {direction, distance}) when direction == :up,    do: {x, y + distance}
  defp determine_key({x, y}, {direction, distance}) when direction == :down,  do: {x, y - distance}
  defp determine_key({x, y}, {direction, distance}) when direction == :left,  do: {x - distance, y}
  defp determine_key({x, y}, {direction, distance}) when direction == :right, do: {x + distance, y}
end

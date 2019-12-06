defmodule Adventofcode.ProgramAlarm do
  def solution(stream, part \\ 1)

  def solution(stream, 1) do
    stream
    |> Stream.map(& (&1 |> string_to_program |> setup_io(12, 2) |> run |> program_to_string))
    |> Enum.join()
  end

  def solution(stream, 2) do
    stream
    |> Stream.map(& (&1 |> string_to_program |> determine_inputs))
    |> Enum.join()
  end

  defp string_to_program(string) do
    string
    |> String.split(",")
    |> Enum.map(& String.to_integer(&1))
  end

  defp program_to_string(program) do
    program
    |> Enum.join(",")
  end

  defp setup_io([output, _, _ | rest], noun, verb) do
    [output, noun, verb | rest]
  end

  defp determine_inputs(program, verb \\ 0, noun \\ 0)
  defp determine_inputs(_, 100, 100), do: nil
  defp determine_inputs(program, 100, noun), do: determine_inputs(program, 0, noun + 1)
  defp determine_inputs(program, verb, noun) do
    [output | _] = program |> setup_io(noun, verb) |> run

    case output do
      output when output == 19690720 -> 100 * noun + verb
      _ -> determine_inputs(program, verb + 1, noun)
    end
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
  def run(program, cursor \\ 0) do
    case Enum.take(Enum.drop(program, cursor), 4) do
      [1, a, b, pos] -> run(List.update_at(program, pos, fn _ -> Enum.at(program, a) + Enum.at(program, b) end), cursor + 4)
      [2, a, b, pos] -> run(List.update_at(program, pos, fn _ -> Enum.at(program, a) * Enum.at(program, b) end), cursor + 4)
      [99 | _] -> program
    end
  end
end

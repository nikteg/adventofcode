defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @moduledoc """
  Run Advent of Code solutions
  """

  @solutions %{
    1 => Adventofcode.RocketEquation,
    2 => Adventofcode.ProgramAlarm
  }

  def run([]) do
    IO.puts("No day given")
  end

  def run([day]) do
    run([day, "1"])
    run([day, "2"])
  end

  def run([day, part]) do
    IO.puts("Day #{day}. Running part #{part}.")
    case run_solution(String.to_integer(day), String.to_integer(part)) do
      {:ok, output} -> IO.puts(output)
      {:error, reason} -> IO.puts(reason)
    end
  end

  defp run_solution(day, part) do
    case Map.get(@solutions, day) do
      nil -> {:error, "No solution found for given day"}
      module -> case get_input_stream(day, part) do
        {:ok, stream} -> {:ok, Kernel.apply(module, :solution, [stream, part])}
        error -> error
      end
    end
  end

  defp get_input_stream(day, part) do
    if File.exists?("inputs/#{day}-#{part}.txt") do
      {:ok, File.stream!("inputs/#{day}-#{part}.txt") |> Stream.map(&String.trim/1)}
    else
      if File.exists?("inputs/#{day}.txt") do
        {:ok, File.stream!("inputs/#{day}.txt") |> Stream.map(&String.trim/1)}
      else
        {:error, "No input found for day #{day}."}
      end
    end
  end
end

defmodule Adventofcode.Utils do
  def get_input_stream(day, part) do
    File.stream!("inputs/#{day}-#{part}.txt")
    |> Stream.map(&String.trim/1)
  end
end

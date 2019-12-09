defmodule Adventofcode.CrossedWires do
  def solution(stream, part \\ 1)

  def solution(stream, 1) do
    [wire_a_string, wire_b_string] = stream |> Enum.to_list()

    run(wire_a_string, wire_b_string)
  end

  def solution(stream, 2) do
    # stream
    # |> Stream.map(& (&1 |> string_to_program |> determine_inputs))
    # |> Enum.join()
  end

  @doc """
  iex> Adventofcode.CrossedWires.run("R8,U5,L5,D3", "U7,R6,D4,L4")
  6
  iex> Adventofcode.CrossedWires.run("R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83")
  159
  iex> Adventofcode.CrossedWires.run("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
  135
  """
  def run(wire_a_string, wire_b_string) do
    origin = {0, 0}

    Map.new()
    |> put_path(origin, :blue, string_to_paths(wire_a_string))
    |> put_path(origin, :green, string_to_paths(wire_b_string))
    # |> print_grid(origin)
    |> Map.to_list()
    |> Enum.filter(fn {_, state} -> state == :crossing end)
    |> Enum.map(fn {coordinate, _} -> get_distance(coordinate, origin) end)
    |> Enum.min()
  end

  defp string_to_paths(string) do
    string
    |> String.split(",")
    |> Enum.map(& parse_path(&1))
  end

  defp put_path(grid, origin, name, path) do
    {new_grid, _} = Enum.reduce(path, {grid, origin}, fn p, {g, o} -> walk(g, o, name, p) end)

    new_grid
  end

  defp print_grid(grid, {origin_x, origin_y}) do
    {{start_x, start_y}, {end_x, end_y}} = get_grid_size(grid)

    IO.puts("\n")

    for x <- start_x..end_x do
      for y <- start_y..end_y do
        if origin_x == x && origin_y == y do
          get_grid_point(:origin) |> IO.write()
        else
          Map.get(grid, {x, y})
          |> get_grid_point()
          |> IO.write()
        end
      end
      IO.write("\n")
    end

    grid
  end

  defp get_grid_size(grid, margin \\ 2) do
    keys = Map.keys(grid)

    {min_x, _} = Enum.min(keys)
    {max_x, _} = Enum.max(keys)
    {_, min_y} = Enum.min_by(keys, fn {_, y} -> y end)
    {_, max_y} = Enum.max_by(keys, fn {_, y} -> y end)

    {{min_x - margin, min_y - margin}, {max_x + margin, max_y + margin}}
  end

  defp colorize(string, color) do
    Kernel.apply(ExChalk, color, [string])
  end

  defp get_grid_point(:crossing), do: colorize("█", :red)
  defp get_grid_point(:origin), do: colorize("█", :yellow)
  defp get_grid_point(nil), do: colorize(" ", :white)
  defp get_grid_point(wire), do: colorize("▒", wire)

  defp parse_path("U" <> distance), do: {:up,    String.to_integer(distance)}
  defp parse_path("D" <> distance), do: {:down,  String.to_integer(distance)}
  defp parse_path("L" <> distance), do: {:left,  String.to_integer(distance)}
  defp parse_path("R" <> distance), do: {:right, String.to_integer(distance)}

  @doc """
  iex> Adventofcode.CrossedWires.walk(%{}, {0, 0}, :a, {:down, 2})
  {%{{0, -1} => :a, {0, -2} => :a}, {0, -2}}
  """
  def walk(grid, origin, name, {direction, distance} = path) do
    new_grid = Enum.reduce(1..distance, grid, fn d, g -> Map.update(g, determine_key(origin, {direction, d}), name, fn
      ^name -> name
      _ -> :crossing
    end) end)

    new_origin = determine_key(origin, path)

    {new_grid, new_origin}
  end

  defp determine_key({x, y}, {direction, distance}) when direction == :up,    do: {x, y + distance}
  defp determine_key({x, y}, {direction, distance}) when direction == :down,  do: {x, y - distance}
  defp determine_key({x, y}, {direction, distance}) when direction == :left,  do: {x + distance, y}
  defp determine_key({x, y}, {direction, distance}) when direction == :right, do: {x - distance, y}

  @doc """
  iex> Adventofcode.CrossedWires.get_distance({0, 0}, {2, 2})
  4
  """
  def get_distance({x, y}, {x2, y2}) do
    abs(x - x2) + abs(y - y2)
  end
end

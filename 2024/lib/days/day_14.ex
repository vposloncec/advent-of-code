defmodule Aoc.Days.Day14 do
  alias Aoc.Helpers.Grid
  alias Aoc.Helpers.Grid.Cell

  def part1(input) do
    robots = parse_input(input)
    IO.inspect(robots)

    width = 11
    height = 7

    steps = 100

    new_positions =
      for {{posx, posy}, {velx, vely}} <- robots do
        IO.inspect({posx, posy, velx, vely})
        {Integer.mod(posx + velx * steps, width), Integer.mod(posy + vely * steps, height)}
      end

    new_positions
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line -> Regex.scan(~r/(-?\d+),(-?\d+)/, line, capture: :all_but_first) end)
    |> Enum.map(fn [[posx, posy], [vx, vy]] ->
      {{String.to_integer(posx), String.to_integer(posy)},
       {String.to_integer(vx), String.to_integer(vy)}}
    end)

    # |> Map.new()

    defp first_quadrant({x, y}, width, height) do
    end
  end
end

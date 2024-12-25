defmodule Aoc.Days.Day17 do
  def part1(rawinput) do
    [a, b, c | prog] = parse_input(rawinput) |> IO.inspect()
  end

  def parse_input(input) do
    Regex.scan(~r/\d+/, input)
    |> Enum.map(fn [x] -> String.to_integer(x) end)
  end
end

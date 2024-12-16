defmodule Aoc.Days.Day14 do
  def part1(input, width, height) do
    robots = parse_input(input)

    steps = 100

    new_positions =
      for {{posx, posy}, {velx, vely}} <- robots do
        {Integer.mod(posx + velx * steps, width), Integer.mod(posy + vely * steps, height)}
      end

    new_positions
    |> count_by_quadrant(width, height)
    |> multiply_values()
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line -> Regex.scan(~r/(-?\d+),(-?\d+)/, line, capture: :all_but_first) end)
    |> Enum.map(fn [[posx, posy], [vx, vy]] ->
      {{String.to_integer(posx), String.to_integer(posy)},
       {String.to_integer(vx), String.to_integer(vy)}}
    end)

    # |> Map.new()
  end

  def part2(input, width, height) do
    robots = parse_input(input)

    steps = 15000
    # IO.puts("")

    scores =
      for i <- 0..steps do
        robots = move_robots(robots, i, height, width)
        score = count_by_quadrant(robots, width, height) |> multiply_values()
        {score, i, robots}
      end

    sorted =
      Enum.sort(scores, fn {score1, _, _}, {score2, _, _} -> score1 <= score2 end)

    for i <- 0..5 do
      {_, _step, robots} = Enum.at(sorted, i)
      # IO.puts("Step #{step}")
      print_positions(robots, height, width)
    end
  end

  defp count_by_quadrant(positions, width, height) do
    x_divider = trunc(width / 2)
    y_divider = trunc(height / 2)

    Enum.reduce(positions, %{}, fn pos, acc ->
      case pos do
        {x, y} when x < x_divider and y < y_divider ->
          Map.update(acc, :q1, 1, &(&1 + 1))

        {x, y} when x > x_divider and y < y_divider ->
          Map.update(acc, :q2, 1, &(&1 + 1))

        {x, y} when x < x_divider and y > y_divider ->
          Map.update(acc, :q3, 1, &(&1 + 1))

        {x, y} when x > x_divider and y > y_divider ->
          Map.update(acc, :q4, 1, &(&1 + 1))

        _ ->
          acc
      end
    end)
  end

  defp print_positions(robots, height, width) do
    for j <- 0..height do
      _line =
        for i <- 0..width do
          if {i, j} in robots, do: "#", else: "."
        end
        |> Enum.join()

      # IO.puts(line)
    end
  end

  defp move_robots(robots, step, height, width) do
    for {{posx, posy}, {velx, vely}} <- robots do
      {Integer.mod(posx + velx * step, width), Integer.mod(posy + vely * step, height)}
    end
  end

  def multiply_values(map) do
    Enum.reduce(map, 1, fn {_key, value}, acc -> acc * value end)
  end
end

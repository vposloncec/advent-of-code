defmodule Aoc.Days.Day12 do
  alias Aoc.Helpers.Grid
  alias Aoc.Helpers.Grid.Cell

  def part1(input) do
    grid = parse_input(input)

    borders =
      grid
      |> find_borders()
      |> Enum.map(fn {{_plant, position}, border_cells} ->
        {position, Enum.count(border_cells)}
      end)
      |> Map.new()

    cells = Grid.with_cell(grid) |> MapSet.new()
    areas = flood_areas(grid, cells)

    Enum.map(areas, &calculate_price(&1, borders)) |> Enum.sum()
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(fn line -> String.split(line, "", trim: true) end)
    |> Grid.new()
  end

  defp find_borders(grid) do
    Grid.with_cell(grid)
    |> Enum.map(fn cell -> {cell, count_neighbours(grid, cell)} end)
  end

  defp count_neighbours(grid, cell) do
    get_different_neighbours(grid, cell)
  end

  defp get_different_neighbours(grid, {value, position}) do
    [:east, :west, :north, :south]
    |> Stream.map(fn dir -> apply(Cell, dir, [position]) end)
    |> Enum.reject(&(Grid.at(grid, &1) == value))
  end

  defp flood_areas(grid, unvisited_cells, areas \\ []) do
    root_cell = Enum.at(unvisited_cells, 0)
    {plant, _root_pos} = root_cell
    current_area = dfs_area(grid, plant, root_cell)
    unvisited_cells = MapSet.difference(unvisited_cells, current_area)

    case(MapSet.size(unvisited_cells)) do
      0 -> [current_area | areas]
      _ -> flood_areas(grid, unvisited_cells, [current_area | areas])
    end
  end

  defp dfs_area(grid, plant, current_cell, acc \\ MapSet.new()) do
    {_plant, current_pos} = current_cell
    acc = MapSet.put(acc, current_cell)

    for new_pos <- Grid.neighbours_4(grid, current_pos), reduce: acc do
      acc ->
        new_plant = Grid.at(grid, new_pos)
        new_cell = {new_plant, new_pos}

        if new_plant == plant && new_cell not in acc do
          dfs_area(grid, plant, new_cell, acc)
        else
          acc
        end
    end
  end

  defp calculate_price(area, borders) do
    border_number =
      for {_plant, position} <- area, reduce: 0 do
        acc -> acc + borders[position]
      end

    # IO.puts("BN: #{border_number}, size: #{MapSet.size(area)}")

    border_number * MapSet.size(area)
  end
end

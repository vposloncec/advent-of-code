defmodule Topography do
  def count_paths(input) do
    matrix = read_as_matrix(input)
    top_map = read_as_map(matrix)

    starts = find_starts(top_map)

    starts
    |> Enum.map(fn start -> move_up_in_all_directions(top_map, start) end)
    |> Enum.map(fn start -> length(start) end)
    |> IO.inspect()
    |> Enum.sum()
  end

  # Not neccessary, but good learning opportunity
  defp read_as_matrix(input) do
    input
    |> String.split("\n")
    |> Enum.reject(&(&1 == ""))
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))
  end

  defp read_as_map(matrix) do
    matrix
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      Enum.with_index(row)
      |> Enum.map(fn {value, x} -> {{x, y}, value} end)
    end)
    |> Map.new()
  end

  defp find_starts(top_map) do
    top_map
    |> Enum.filter(fn {_pos, v} -> v == 0 end)
    |> Enum.map(fn {pos, _v} -> pos end)
  end

  defp move_up(top_map, {x, y}, backtrack \\ []) do
    case top_map[{x, y}] do
      nil -> {:error, :out_of_bounds}
      9 -> {:ok, [{x, y} | backtrack]}
      _ -> move_up_in_all_directions(top_map, {x, y}, backtrack)
    end

    # _ -> move_up_first_possible_position(top_map, {x, y}, backtrack)
  end

  defp move_up_first_possible_position(top_map, {x, y}, backtrack) do
    [{x, y - 1}, {x, y + 1}, {x + 1, y}, {x - 1, y}]
    |> Enum.find(next_step_callback(top_map, {x, y}))
    |> case do
      nil ->
        IO.puts("No possible moves from #{inspect({x, y})}")
        {:error, :no_possible_moves}

      pos ->
        IO.puts("Moving to #{top_map[pos]}, new position: #{inspect(pos)}")
        move_up(top_map, pos, [{x, y} | backtrack])
    end
  end

  defp move_up_in_all_directions(top_map, {x, y}, backtrack \\ []) do
    directions = [{x, y - 1}, {x, y + 1}, {x + 1, y}, {x - 1, y}]

    directions
    |> Enum.reject(&(top_map[&1] != top_map[{x, y}] + 1))
    |> Enum.map(fn newpos ->
      {status, result} = move_up(top_map, newpos, [{x, y} | backtrack])

      case status do
        :ok -> result
        _ -> nil
      end
    end)
    |> Enum.reject(&is_nil/1)
  end

  defp next_step_callback(top_map, oldpos) do
    fn newpos -> top_map[oldpos] + 1 == top_map[newpos] end
  end
end

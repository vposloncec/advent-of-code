import Bitwise

defmodule Aoc.Days.Day17 do
  def part1(rawinput) do
    [a, b, c | prog] = parse_input(rawinput)

    run_program(prog, a, b, c)
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join(",")
  end

  def part2(rawinput) do
    [_, b, c | prog] = parse_input(rawinput)

    # When last digit found -> * 8
    # When not found -> + 8
    # Backtrack if not found in first 8 of new iteration 
    Stream.unfold({1, 0}, fn {i, counter} ->
      run = run_program(prog, i, b, c)
      current_elems_prog = prog |> Enum.reverse() |> Enum.take(length(run)) |> Enum.reverse()

      # IO.puts( "Current elems prog: #{current_elems_prog |> as_string()} Run: #{run |> as_string()}, i: #{i}")

      case run do
        # ^prog -> IO.puts("Found prog #{prog}: #{i}") && nil
        ^prog ->
          nil

        # IO.puts("Found element #{current_elems_prog |> as_string}: #{i}") && {i * 8, {i * 8, 0}}
        ^current_elems_prog ->
          {i * 8, {i * 8, 0}}

        # IO.puts("x (i: #{i}): #{out |> as_string()}") && {i + 1, i + 1}
        _ ->
          case counter do
            8 -> {div(i, 8), {div(i, 8) + 1, 0}}
            _ -> {i + 1, {i + 1, counter + 1}}
          end
      end
    end)
    |> Enum.to_list()
    |> Enum.at(-1)
  end

  def run_program(prog, a, b, c) do
    execute(prog, prog, a, b, c, [])
    |> Enum.reverse()
  end

  def execute(_, [], _, _, _, out), do: out

  def execute(full, prog, a, b, c, out) do
    # IO.puts("Prog: #{inspect(prog)}, a #{a}, b #{b}, c #{c},  out #{out}")
    [op, literal | rest] = prog

    combo =
      case literal do
        4 -> a
        5 -> b
        6 -> c
        7 -> raise "Invalid operand"
        _ -> literal
      end

    case op do
      0 -> execute(full, rest, a >>> combo, b, c, out)
      1 -> execute(full, rest, a, bxor(literal, b), c, out)
      2 -> execute(full, rest, a, rem(combo, 8), c, out)
      3 when a == 0 -> execute(full, rest, a, b, c, out)
      3 -> execute(full, Enum.drop(full, literal), a, b, c, out)
      4 -> execute(full, rest, a, bxor(b, c), c, out)
      5 -> execute(full, rest, a, b, c, [rem(combo, 8) | out])
      6 -> execute(full, rest, a, a >>> combo, c, out)
      7 -> execute(full, rest, a, b, a >>> combo, out)
      _ -> out
    end
  end

  defp as_string(program_output) do
    program_output
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join(",")
  end

  def parse_input(input) do
    Regex.scan(~r/\d+/, input)
    |> Enum.map(fn [x] -> String.to_integer(x) end)
  end
end

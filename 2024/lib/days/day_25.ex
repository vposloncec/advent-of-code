defmodule Aoc.Days.Day25 do
  def part1(rawinput) do
    input = String.split(rawinput, "\n\n")
    {locks, keys} = Enum.split_with(input, &String.starts_with?(&1, "#####"))

    {locks, keys} =
      {Enum.map(locks, &parse_input/1), Enum.map(keys, &parse_input/1)}

    find_fitting_pairs(locks, keys)
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> then(fn v -> {length(v) - 2, count_hashtags(v)} end)
  end

  def find_fitting_pairs(locks, keys) do
    for lock <- locks, key <- keys, fits?(lock, key), reduce: 0 do
      acc -> acc + 1
    end
  end

  def count_hashtags(lines) do
    lines
    |> Enum.map(&String.graphemes/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    # |> IO.inspect()
    |> Enum.map(fn el -> Enum.count(el, &(&1 == "#")) - 1 end)
  end

  def fits?({len_lock, lock}, {_len_key, key}) do
    IO.puts("")

    Enum.zip(lock, key)
    |> Enum.map(fn {a, b} -> a + b end)
    |> Enum.all?(fn x -> x <= len_lock end)
  end

  def part2(_input) do
  end
end

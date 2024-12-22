import Bitwise

defmodule Aoc.Days.Day22 do
  def part1(input) do
    parse_input(input)
    |> Enum.map(&run_iteration(&1, 2000))
    |> Enum.sum()
  end

  def part2(input) do
    nums = parse_input(input)

    bananamaps =
      nums
      |> Enum.map(&num_to_bananmap(&1))

    bananamap =
      bananamaps
      |> Enum.reduce(%{}, fn map, acc ->
        Map.merge(map, acc, fn _key, v1, v2 -> v1 + v2 end)
      end)

    {_key, value} = Enum.max_by(bananamap, fn {_key, value} -> value end)
    value
  end

  def num_to_bananmap(num) do
    combined_gen(num)
    |> Stream.take(1996)
    |> Enum.reduce(%{}, fn {num, last4}, acc ->
      Map.put_new(acc, last4, num)
    end)
  end

  def parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def mix(n1, n2) do
    bxor(n1, n2)
  end

  def run_iteration(num, 0), do: num

  def run_iteration(num, iterations) do
    num
    |> evolve_number()
    |> run_iteration(iterations - 1)
  end

  def combined_gen(num) do
    Stream.zip(shortened_sequence_generator(num), last_4_diffs(num))
  end

  def shortened_sequence_generator(num) do
    sequence_generator(num) |> Stream.drop(4)
  end

  def sequence_generator(num) do
    Stream.iterate(num, &evolve_number(&1))
    |> Stream.map(&rem(&1, 10))
  end

  def last_4_diffs(num) do
    diff_stream(num)
    |> Stream.chunk_every(4, 1, :discard)
  end

  def diff_stream(num) do
    sequence_generator(num)
    |> Stream.chunk_every(2, 1, :discard)
    |> Stream.map(&(Enum.at(&1, 1) - Enum.at(&1, 0)))
  end

  def evolve_number(num) do
    first =
      (num * 64)
      |> mix(num)
      |> prune

    second =
      first
      |> Kernel./(32)
      |> floor()
      |> mix(first)
      |> prune

    second |> Kernel.*(2048) |> mix(second) |> prune
  end

  def prune(num) do
    rem(num, 16_777_216)
  end
end

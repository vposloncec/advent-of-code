defmodule Day17Test do
  use ExUnit.Case, async: true

  alias Aoc.Days.Day17

  @test_example """
                Register A: 729
                Register B: 0
                Register C: 0

                Program: 0,1,5,4,3,0
                """
                |> String.trim()

  test "calculates part1 example" do
    assert @test_example |> Day17.part1() == 140
  end

  @tag :skip
  test "calculates part1 example 2" do
    assert @test_example |> Day17.part1() == 1930
  end

  @tag :skip
  test "calculates part1 actual" do
    assert test_actual() |> Day17.part1() == 1_473_276
  end

  def test_actual do
    """
    Register A: 45483412
    Register B: 0
    Register C: 0

    Program: 2,4,1,3,7,5,0,3,4,1,1,5,5,5,3,0

    """
  end
end

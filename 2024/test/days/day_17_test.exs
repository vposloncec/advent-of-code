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

  @test_example2 """
  Register A: 2024
  Register B: 0
  Register C: 0

  Program: 0,3,5,4,3,0
  """

  test "calculates part1 example" do
    assert @test_example |> Day17.part1() == "4,6,3,5,6,3,5,2,1,0"
  end

  test "calculates part1 actual" do
    assert test_actual() |> Day17.part1() == "1,5,0,5,2,0,1,3,5"
  end

  test "calculates part2 example" do
    assert @test_example2 |> Day17.part2() == 117_440
  end

  test "calculates part2 actual" do
    assert test_actual() |> Day17.part2() == 236_581_108_670_061
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

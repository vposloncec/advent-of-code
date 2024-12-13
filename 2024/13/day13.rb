require 'debug'
require_relative 'machine'

class Day13
  MAX_PRESS = 100
  def initialize(input)
    input = input.strip.split("\n").reject(&:empty?)
    @machines = []
    input.each_slice(3) do |lines|
      ax, ay = lines[0].scan(/.\d+/).map(&:to_i)
      bx, by = lines[1].scan(/.\d+/).map(&:to_i)
      prizex, prizey = lines[2].scan(/\d+/).map(&:to_i)
      a = [ax, ay]
      b = [bx, by]
      prize = [prizex, prizey]
      @machines << Machine.new(a:, b:, prize:, cost_a: 3, cost_b: 1)
    end
  end

  def part1
    # haha, I did elixir yesterday, does it show?
    machines
      .map(&:solve)
      .filter { |sols| sols.all? { |sol| (sol % 1).zero? && sol <= MAX_PRESS } }
      .map { |a, b| 3 * a.to_i + b.to_i }
      .sum
  end

  def part2
    machines
      .map { |m| m.increase_prize(10_000_000_000_000) }
      .map(&:solve)
      .filter { |sols| sols.all? { |sol| (sol % 1).zero? } }
      .map { |a, b| 3 * a.to_i + b.to_i }
      .sum
  end

  attr_reader :input, :machines

  def buttons
    %i[a b]
  end

  def greedy_preference
    :b
  end

  def move(curr_pos, token)
    [curr_pos[0] - token[0], curr_pos[1] - token[1]]
  end
end

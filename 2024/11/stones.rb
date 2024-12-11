# frozen_string_literal: true

require 'debug'
class Stones
  def initialize(input)
    @input = input.strip.split
    @memo = {}
    @memo_iterations = {}
    init_memo_iterations
  end

  def part1
    # 25.times.reduce(input) { |sum, _n| transform(sum) }.size
    input.each { |num| memo_iterations(num, 25) }.size
  end

  def part2
    input.each { |num| memo_iterations(num, 25) }.size
  end

  attr_reader :grid, :input

  def memo_iterations(num, iterations)
    @memo_iterations[[num, iterations]] ||= transform(iterations - 1)
  end

  def transform(iteration)
    iteration.each_with_object([]) do |num, acc|
      acc.append(*calculate_with_memo(num))
    end
  end

  def calculate_with_memo(num)
    @memo[num] ||= calculate_next(num)
  end

  def calculate_next(num)
    if num == '0'
      '1'
    elsif num.size.even?
      split_number(num)
    else
      (num.to_i * 2024).to_s
    end
  end

  def split_number(num)
    mid = num.length / 2
    [num[0...mid], num[mid..].to_i.to_s]
  end

  def init_memo_iterations
    input.each do |num|
      @memo_iterations[[num, 1]] = Array(calculate_with_memo(num))
    end
  end
end

# frozen_string_literal: true

require 'debug'
class Stones
  def initialize(input)
    @input = input.strip.split
    @memo = {}
    @memo_count = {}
  end

  def part1
    input.sum do |num|
      count_after_blink(num, 25)
    end
  end

  def part2
    input.sum do |num|
      count_after_blink(num, 75)
    end
  end

  attr_reader :grid, :input

  def count_after_blink(num, blink_count)
    return calculate_single(num).size if blink_count == 1

    @memo_count[[num, blink_count]] ||= calculate_single(num).sum do |n|
      count_after_blink(n, blink_count - 1)
    end
  end

  def transform(iteration)
    iteration.each_with_object([]) do |num, acc|
      acc.append(*calculate_single(num))
    end
  end

  def calculate_single(num)
    @memo[num] ||= Array(calculate_next(num))
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
end

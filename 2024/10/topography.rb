require 'debug'
class Topography
  def initialize(input)
    @input = input
    parse_grid
  end

  def part1
    p grid
    paths = grid.filter { |_k, v| v.zero? }.map { |k, _v| find_paths(k) }
    sizes = paths.count { |start_paths| start_paths.size }
    paths.sum { |start_paths| start_paths.each.size }
  end

  attr_reader :grid, :input

  def parse_grid
    @grid = {}
    input.split("\n").map(&:strip).reject(&:empty?).each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        @grid[[x, y]] = char.to_i
      end
    end
  end

  def find_paths(start)
    queue = [start]
    paths = []
    while queue.any?
      current = queue.shift
      puts "Current: #{current}, queue: #{queue}"
      if grid[current] == 9
        paths << current
        next
      end
      neighbours = neighbours(current)
      neighbours.each do |neighbour|
        next if grid[neighbour].nil?
        next if grid[neighbour] != grid[current] + 1
        # Don't go again in same spot
        next if paths.include?(neighbour)
        next if queue.include?(neighbour)

        queue << neighbour
      end
    end
    paths
  end

  def neighbours(pos)
    [[pos[0] - 1, pos[1]], [pos[0] + 1, pos[1]], [pos[0], pos[1] - 1], [pos[0], pos[1] + 1]]
  end
end

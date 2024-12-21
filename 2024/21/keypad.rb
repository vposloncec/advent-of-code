# frozen_string_literal: true

require 'debug'
require 'algorithms'

class Keypad
  KEYPAD_NUM = <<~KEYPADNUM
    789
    456
    123
    .0A
  KEYPADNUM
  KEYPAD_ROB = <<~KEYPADROB
    .^A
    <v>
  KEYPADROB

  attr_reader :codes, :kp_n, :kp_r, :kp_r2

  def initialize(input)
    @codes = input.split("\n").map(&:strip)
    # Keypad for doors (kp_n) and for robots (kp_r)
    @kp_n = KeyPadGrid.new(KEYPAD_NUM)
    @kp_r = KeyPadGrid.new(KEYPAD_ROB)
    @kp_r2 = KeyPadGrid.new(KEYPAD_ROB)
  end

  def part1
    puts KEYPAD_NUM
    puts KEYPAD_ROB
    codes.map do |code|
      puts "Sum of code #{code} is #{part1v2(code)} * #{code[0..2].to_i}"
      part1v2(code) * code[0..2].to_i
    end.sum

    # final = {}
    # aha = codes[0].chars.flat_map do |code|
    #   a = find_path(kp_n, kp_n.next_start, kp_n.grid.key(code))
    #   all_perms = a.chars.permutation.map(&:join).uniq.map { |x| x << 'A' }
    #   all_perms.each do |perm|
    #     second_level = perm.chars.flat_map do |code2|
    #       be = find_path(kp_r, kp_r.next_start, kp_r.grid.key(code2))
    #       bee = be.chars.permutation.map(&:join).uniq.map { |x| x << 'A' }
    #       debugger
    #     end
    #   end
    #
    #   # bi = a.each.each_char.map { |c| "#{find_path(kp_r, kp_r.grid.key(c)).chars.sort.join}A" }
    #   # ci = bi.join.each_char.map { |c| "#{find_path(kp_r2, kp_r2.grid.key(c)).chars.sort.join}A" }
    #   # final[code] = [a, bi, ci]
    #   debugger
    #   # ci.join
    # end
    # debugger
  end

  def part1v2(full_code)
    start = kp_n.grid.key('A')
    res = full_code.chars.map do |char|
      puts "Calling find_for with start: #{start}, goal: #{kp_n.grid.key(char)}"
      a = find_for(kp_n, start, kp_n.grid.key(char), 0)
      start = kp_n.grid.key(char)
      a
    end
    debugger
  end

  def find_for(grid, start, goal, level)
    # Calculate cost of move on level 2
    if level == 2
      path = find_path(kp_r2, start, goal)
      sol = path.size + 1

      # bee = a.chars.permutation.map(&:join).uniq.map { |x| x << 'A' }
      # puts "REACHED END OF RECURSION, returning #{sol} for path #{path}"
      return [sol, "#{path}A"]
    end

    path = find_path(grid, start, goal)
    # puts "Current path: #{path}"
    start_new = kp_r.grid.key('A')
    be = path.chars.permutation.map(&:join).uniq.map { |x| x << 'A' }
    # puts "Created codes: #{be}"
    all_costs = be.map do |code|
      puts "Found CODE: #{code} on level #{level}"
      price, arr = code.chars.map do |char|
        a = find_for(kp_r, start_new, kp_r.grid.key(char), level + 1)
        start_new = kp_r.grid.key(char)
        a
      end
      puts "Calculated cost of #{code} on level #{level} price #{price}: #{arr}"
      price
    end
    mini = all_costs.min { |a, b| a[0] <=> b[0] }
    puts "For #{grid.grid[goal]} (#{goal}), All costs: #{all_costs} for be: #{be}, level: #{level}, minimmum: #{mini}"
    # puts "Returning codes from find for (level #{level}: #{new_things}"
    # new_things

    # path = find_path(grid, start, goal)
    # be = path.chars.permutation.map(&:join).uniq.map { |x| x << 'A' }
    mini
  end

  def all_paths(grid, goal)
    find_path(grid, goal).chars.permutation.to_a
  end

  def find_path(grid, start, goal)
    # Elements in queue are [[position, string_moves], len(string_moves)], priority queue return element with shortest string_moves
    distances = {}
    queue = Containers::PriorityQueue.new { |x, y| (x <=> y) == -1 }
    queue.push([start, ''], 0)
    until queue.empty?
      curr = queue.pop
      return curr[1] if curr[0] == goal
      next if distances.key?(curr[0]) && distances[curr[0]] <= curr[1].size

      distances[curr[0]] = curr[1].size

      next_moves(grid, *curr).each do |m|
        queue.push(m, m[1].size)
      end
    end
  end

  def next_moves(grid, position, existing_moves)
    a = [[:west, '<'], [:north, '^'], [:south, 'v'], [:east, '>']].map do |direction, symbol|
      new_position = grid.send(direction, position)
      next unless grid.valid?(new_position)

      [new_position, existing_moves + symbol]
    end.compact
  end

  class KeyPadGrid
    def initialize(input)
      @grid = input.split("\n").each_with_index.each_with_object({}) do |(line, y), acc|
        line.chars.each_with_index do |char, x|
          acc[[x, y]] = char
        end
      end
      @next_start = grid.key('A')
    end

    attr_reader :grid
    attr_accessor :next_start

    def east(pos)
      [pos[0] + 1, pos[1]]
    end

    def north(pos)
      [pos[0], pos[1] - 1]
    end

    def south(pos)
      [pos[0], pos[1] + 1]
    end

    def west(pos)
      [pos[0] - 1, pos[1]]
    end

    def in_bounds?(pos)
      grid.key?(pos)
    end

    def valid?(pos)
      in_bounds?(pos) && grid[pos] != '.'
    end
  end
end

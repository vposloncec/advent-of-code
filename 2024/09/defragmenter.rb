require 'debug'
class Defragmenter
  def initialize(input)
    @input = input
  end

  attr_reader :input, :representation, :defragmented, :checksum

  def calculate
    create_representation
    defragment
    calculate_checksum
  end

  def calculate_whole
    create_representation
    defragment_maintain_whole_file
    calculate_checksum
  end

  def create_representation
    char_index = 0
    @representation = input.chars.each_with_object([]) do |c, out|
      next char_index += 1 if c.to_i.zero?

      if char_index.even?
        out.concat(Array.new(c.to_i, (char_index / 2)))
      else
        out.concat(Array.new(c.to_i, '.'))
      end
      char_index += 1
    end
  end

  def defragment
    defragmented = representation.dup
    while (dot_index = defragmented.index('.')) <
          (right_index = defragmented.rindex { |n| n.is_a?(Numeric) })
      defragmented[dot_index], defragmented[right_index] = defragmented[right_index], defragmented[dot_index]
    end
    @defragmented = defragmented
  end

  def defragment_maintain_whole_file
    defragmented = representation.dup
    rchunked = defragmented.reverse.each_with_index.chunk_while { |(a, ai), (b, bi)| a == b }.to_a
    ddefragmented = rchunked.each do |chunk, i|
      next unless chunk[0].is_a?(Numeric)

      left_big_enough_dot_index = rchunked.rindex { |elem| elem.size >= chunk.size && elem.all? { |e| e == '.' } }
      next if left_big_enough_dot_index.nil? || left_big_enough_dot_index < i

      debugger
      chunk.size.times do |j|
        rchunked[i][j], rchunked[left_big_enough_dot_index][j] = rchunked[left_big_enough_dot_index][j],
rchunked[i][j]
      end
    end
    debugger
    @defragmented = ddefragmented.reverse.flatten
  end

  def calculate_checksum
    last_num = defragmented.rindex { |n| n.is_a?(Numeric) }
    @checksum = defragmented[0..last_num].each_with_index.sum do |c, i|
      c.to_i * i
    end
  end
end

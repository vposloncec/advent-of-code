require 'debug'
class Defragmenter
  def initialize(input)
    @input = input
  end

  Num = Struct.new(:val, :index)

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
    defragmented = representation.each_with_index.map do |c, i|
      Num.new(c, i)
    end
    defragmented.reverse.chunk_while { |a, b| a.val == b.val }.each do |chunk|
      next unless chunk[0].val.is_a?(Numeric)

      left_big_enough_dot_index = find_spaces(defragmented[0..chunk[-1].index], chunk.size)
      next unless left_big_enough_dot_index

      chunk.size.times do |j|
        defragmented[left_big_enough_dot_index + j].val, defragmented[chunk[-1].index + j].val =
          defragmented[chunk[-1].index + j].val, defragmented[left_big_enough_dot_index + j].val
      end
    end
    @defragmented = defragmented
  end

  def calculate_checksum
    last_num = defragmented.rindex { |n| n.is_a?(Numeric) }
    @checksum = defragmented[0..last_num].each_with_index.sum do |c, i|
      if c.is_a?(Num)
        c.val.to_i * i
      else
        c.to_i * i
      end
    end
  end

  def find_spaces(array, spaces)
    array.each_cons(spaces) do |chunk|
      return chunk[0].index if chunk.all? { |c| c.val == '.' }
    end

    nil
  end
end

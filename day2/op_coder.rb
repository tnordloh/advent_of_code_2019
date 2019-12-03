require 'pry'
class OpCoder
  def initialize(list)
    @list = list.each_slice(4).to_a
  end
  attr_accessor :list

  def multiply(value_1, value_2, destination)
    normalize_and_update(destination, value_1 * value_2)
  end

  def add(value_1, value_2, destination)
    normalize_and_update(destination, value_1 + value_2)
  end

  def process_all
    list.each { |instruction| 
      break if instruction[0] == 99
      process(instruction)
    }
  end

  def process(instruction)
    if instruction[0] == 1
      add(
        normalize[instruction[1]],
        normalize[instruction[2]],
        instruction[3]
      )
    elsif instruction[0] == 2
      multiply(
        normalize[instruction[1]],
        normalize[instruction[2]],
        instruction[3]
      )
    end
  end

  def normalize
    @list.flatten
  end

  def normalize_and_update(position, value)
    @list = @list.flatten
    @list[position] = value
    @list = list.each_slice(4).to_a
  end
end

0.upto(99) do |noun|
  0.upto(99) do |verb|
    x = File.readlines('input.txt').first.split(',').map(&:to_i)
    x[1] = noun
    x[2] = verb
    op_coder = OpCoder.new(x)
    op_coder.process_all
    if op_coder.normalize[0] == 19690720
      p "Got a match on #{100 * noun + verb}"
    end
  end
end

require 'pry'
class OpCoder
  def initialize(list, input = nil)
    @list = list
    @position = 0
    @input = input
    @output = nil
  end
  attr_accessor :list, :position

  def multiply(pmodes = [0,0,0])
    param_1 = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    param_2 = pmodes[1] == 0 ? list[list[position + 2]] : list[position + 2]
    param_3 = pmodes[2] == 0 ? list[list[position + 3]] : list[position + 3]
    list[list[position + 3]] = param_1 * param_2
    @position += 4
  end

  def add(pmodes = [0,0,0])
    param_1 = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    param_2 = pmodes[1] == 0 ? list[list[position + 2]] : list[position + 2]
    param_3 = pmodes[2] == 0 ? list[list[position + 3]] : list[position + 3]
    list[list[position + 3]] = param_1 + param_2
    @position += 4
  end

  def jump_if_true(pmodes)
    param_1 = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    param_2 = pmodes[1] == 0 ? list[list[position + 2]] : list[position + 2]
    if param_1.zero?
      @position += 3
    else
      @position = param_2
    end
  end

  def jump_if_false(pmodes)
    param_1 = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    param_2 = pmodes[1] == 0 ? list[list[position + 2]] : list[position + 2]
    if param_1.zero?
      @position = param_2
    else
      @position += 3
    end
  end
  
  def equals(pmodes)
    param_1 = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    param_2 = pmodes[1] == 0 ? list[list[position + 2]] : list[position + 2]
    list[list[position + 3]] = param_1 == param_2 ? 1 : 0
    @position += 4
  end

  def less_than(pmodes)
    param_1 = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    param_2 = pmodes[1] == 0 ? list[list[position + 2]] : list[position + 2]
    list[list[position + 3]] = param_1 < param_2 ? 1 : 0
    @position += 4
  end

  def input
    list[list[position + 1]] = @input
    binding.pry
    @position += 2
  end

  def output(pmodes)
    @output = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    binding.pry
    p @output
    @position += 2
  end

  def process_all
    until list[position] == 99 do
      process
    end
  end

  def process
    (rem, opcode) = list[position].divmod(100)
    (rem, first_parameter_mode) = rem.divmod(10)
    (third_parameter_mode, second_parameter_mode) = rem.divmod(10)
    pmodes = [first_parameter_mode, second_parameter_mode, third_parameter_mode]
    case opcode
    when 1
      add(pmodes)
    when 2
      multiply(pmodes)
    when 3
      input()
    when 4
      output(pmodes)
    when 5
      jump_if_true(pmodes)
    when 6
      jump_if_false(pmodes)
    when 7
      less_than(pmodes)
    when 8
      equals(pmodes)
    when 99
      "finished"
      exit
    end
  end
end

x = File.readlines('input.txt').first.split(',').map(&:to_i)
op_coder = OpCoder.new(x, 5)
op_coder.process_all

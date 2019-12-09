require 'pry'
class OpCoder
  def initialize(list, this_input = nil)
    @list = list
    @position = 0
    @input = this_input
    @output = nil
    @done = false
  end
  attr_accessor :list, :position
  attr_reader :output

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

  def consume_output
    returnme = @output
    @output = nil
    returnme
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
    list[list[position + 1]] = @input.shift
    @position += 2
  end

  def add_input(input)
    @input << input
  end

  def output=(pmodes)
    @output = pmodes[0] == 0 ? list[list[position + 1]] : list[position + 1]
    @position += 2
  end

  def process_to_output
    while @output.nil? && !done? do
      process
    end
  end
  
  def done?
    @done
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
      self.output=(pmodes)
    when 5
      jump_if_true(pmodes)
    when 6
      jump_if_false(pmodes)
    when 7
      less_than(pmodes)
    when 8
      equals(pmodes)
    when 99
      @done = true
    end
  end
end

def get_op_coder(phase)
  x = File.readlines('input.txt').first.split(',').map(&:to_i)
  op_coder = OpCoder.new(x, [phase])
end
possibles = (5..9).to_a.permutation(5).each_with_object({}) do |permutation, acc|
  p permutation
  amp_a = get_op_coder(permutation[0])
  amp_b = amp_c = amp_d = amp_e = nil
  amp_e_input = 0
  while !amp_a.done? do
    amp_a.add_input(amp_e_input)
    amp_a.process_to_output
    amp_a_input = amp_a.consume_output
    amp_b ||= get_op_coder(permutation[1])
    amp_b.add_input(amp_a_input)
    amp_b.process_to_output
    amp_b_input = amp_b.consume_output
    amp_c ||= get_op_coder(permutation[2])
    amp_c.add_input(amp_b_input)
    amp_c.process_to_output
    amp_c_input = amp_c.consume_output
    amp_d ||= get_op_coder(permutation[3])
    amp_d.add_input(amp_c_input)
    amp_d.process_to_output
    amp_d_input = amp_d.consume_output
    amp_e ||= get_op_coder(permutation[4])
    amp_e.add_input(amp_d_input)
    amp_e.process_to_output
    if amp_a.done?
      acc[amp_e_input] = permutation
    end
    amp_e_input = amp_e.consume_output
  end
end
p possibles.keys.max
p possibles.keys.min
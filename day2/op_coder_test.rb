require 'rspec/autorun'
require_relative 'op_coder'

describe OpCoder do
  describe '.list' do
    it "can chunk up a program" do
      program = [1,9,10,3,2,3,11,0,99,30,40,50]
      op_coder = OpCoder.new(program)

      expect(op_coder.list.first).to eq([1,9,10,3])
    end
  end
  describe '.multiply' do
    it 'can multiply two numbers' do
      program = [1,2,3,0]
      op_coder = OpCoder.new(program)
      op_coder.multiply(2,3,3)

      expect(op_coder.list.first).to eq([1,2,3,6])
    end
  end
  describe '.add' do
    it "can do addition" do
      program = [1,1,1,0]
      op_coder = OpCoder.new(program)
      op_coder.add(1,1,3)

      expect(op_coder.list.first).to eq([1,1,1,2])
    end
  end
  describe '.process' do
    it "can do process an addition instruction" do
      program = [1,3,1,2]
      op_coder = OpCoder.new(program)
      op_coder.process(program)

      expect(op_coder.list.first).to eq([1,3,5,2])
    end
    it "can do process a multiply instruction" do
      program = [2,3,1,2]
      op_coder = OpCoder.new(program)
      op_coder.process(program)

      expect(op_coder.list.first).to eq([2,3,6,2])
    end
  end
  describe '.process_all' do
    it "can process all instructions" do
      program = [1,9,10,3,2,3,11,0,99,30,40,50]
      op_coder = OpCoder.new(program)
      op_coder.process_all
      expected = [
        3500,9,10,70,
        2,3,11,0,
        99,30,40,50
      ]
      expect(op_coder.normalize).to eq(expected)
    end
  end
end

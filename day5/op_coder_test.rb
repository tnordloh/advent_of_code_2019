require 'rspec/autorun'
require_relative 'op_coder'

describe OpCoder do
  describe '.multiply' do
    it 'can multiply two numbers' do
      program = [2,2,2,0,99]
      op_coder = OpCoder.new(program)
      op_coder.process_all

      expect(op_coder.list).to eq([4,2,2,0,99])
    end
  end
  describe '.add' do
    it "can do addition" do
      program = [1,1,1,0,99]
      op_coder = OpCoder.new(program)
      op_coder.process_all

      expect(op_coder.list).to eq([2,1,1,0,99])
    end
  end
  describe '.process' do
    it "can do process an addition instruction" do
      program = [1,3,1,2,99]
      op_coder = OpCoder.new(program)
      op_coder.process_all

      expect(op_coder.list).to eq([1,3,5,2,99])
    end
    it "can do process a multiply instruction" do
      program = [2,3,1,2,99]
      op_coder = OpCoder.new(program)
      op_coder.process_all

      expect(op_coder.list).to eq([2,3,6,2,99])
    end
  end
  describe '.process_all' do
    it "can process all instructions" do
      program = [1,9,10,3,2,3,11,0,99,30,40,50,99]
      op_coder = OpCoder.new(program)
      op_coder.process_all
      expected = [
        3500,9,10,70,
        2,3,11,0,
        99,30,40,50,99
      ]
      expect(op_coder.list).to eq(expected)
    end
  end
end

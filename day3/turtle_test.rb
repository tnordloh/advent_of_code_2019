require 'rspec/autorun'
require_relative 'turtle'

describe Turtle do
  describe '.draw_line' do
    it "can draw a line up" do
      t = Turtle.new
      t.draw_line('U5')
      expected =
      {
        [0,0] => true, [0,1] => true, [0,2] => true, [0,3] => true, [0, 4] => true, [0, 5] => true
      }
      expect(t.spot).to eq(expected)
      expect(t.position).to eq([0,5])
      expected2 = expected.merge(
        [0,5] => true, [1,5] => true, [2,5] => true, [3,5] => true, [4, 5] => true, [5, 5] => true

      )
      t.draw_line('R5')
      expect(t.spot).to eq(expected2)
      expect(t.position).to eq([5,5])
    end
  end
end

require 'pry'
class Turtle
  def initialize
    @spot = Hash.new
    @position = [0, 0]
    @steps_taken = 0
    @spot[@position] = true
  end
  attr_accessor :spot, :position, :steps_taken

  def draw_line(string, intersection = nil)
    direction,distance = [string.chars.first, string.chars[1..-1].join.to_i]
    case direction
    when "U"
      (position[1]...(position[1] + distance)).each do |i|
        @steps_taken += 1
        @position = [position[0], i + 1]
        spot[@position] = steps_taken unless spot[@position]
        return steps if spot == intersection
      end
    when "D"
      ((position[1] - distance)...position[1]).to_a.reverse.each do |i|
        @steps_taken += 1
        p "i"
        p i
        p "before"
        p position
        @position = [position[0], i - 1]
        p "after"
        p position
        spot[@position] = steps_taken unless spot[@position]
        return steps if spot == intersection
      end
    when "L"
      ((position[0] - distance)...position[0]).to_a.reverse.each do |i|
        @steps_taken += 1
        @position = [i, position[1]]
        spot[@position] = steps_taken unless spot[@position]
        return steps if spot == intersection
      end
    when "R"
      (position[0]...(position[0] + distance)).each do |i|
        @steps_taken += 1
        @position = [i + 1, position[1]]
        spot[@position] = steps_taken unless spot[@position]
        return steps if spot == intersection
      end
    end
  end
end

@intersections = [[-877, -656], [-361, -656], [-196, -1028], [0, 0], [372, -1948], [372, -1877], [921, -1459], [921, -1430], [1146, -1459]]
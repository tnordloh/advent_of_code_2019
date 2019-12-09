class Orbits
  def initialize(orbits)
    @orbits = orbits
    @planet_list = Hash.new([])
    @depth = {"COM" => 0}
    find_orbits
  end
  attr_accessor :orbits, :planet_list, :depth

  def find_orbits
    @orbits.each do |orbit|
      planet, moon = orbit.split(')')
      @planet_list[planet] = @planet_list[planet].dup << moon
    end
  end

  def find_depths
    orbit_count = 0
    p @planet_list
    leaves = ["COM"]
    while leaves.size > 0
      current_planet = leaves.pop
      @planet_list[current_planet].each do |moon|
        depth[moon] = depth[current_planet] + 1
      end
      leaves << @planet_list[current_planet]
      leaves.flatten!
    end
    p depth.values.sum
  end
end

# leaves = ["COM"]
# 
# depth = {"COM" => 0}
# orbit_count = 0
# p @planet_list
# while leaves.size > 0
#   current_planet = leaves.pop
#   @planet_list[current_planet].each do |moon|
#     binding.pry
#     depth[moon] = depth[current_planet] + 1
#   end
#   leaves << @planet_list[current_planet]
# end
# p depth.values.sum

require 'pry'
orbits = File.readlines('input.txt').map(&:chomp)
o = Orbits.new(orbits)

o.find_depths
binding.pry
p o
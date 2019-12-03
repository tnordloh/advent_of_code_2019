class FuelCounterUpper
  def self.fuel(mass:)
    [0, mass / 3 - 2].max
  end
  def self.fuel2(mass:)
    new_mass = self.fuel(mass: mass)
    if new_mass <= 0
      new_mass
    else
      new_mass + self.fuel2(mass: new_mass)
    end
  end
end

puts File.readlines('input.txt').reduce(0) {|acc,i| acc + FuelCounterUpper.fuel2(mass: i.to_i)}
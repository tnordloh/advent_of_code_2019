require 'rspec/autorun'
require_relative 'fuel_counter_upper'

describe FuelCounterUpper do
  describe '.draw_line' do
    it "finds 2 from 12" do
      expect(FuelCounterUpper.fuel(mass: 12)).to eq(2)
    end
    it "finds 2 from 14" do
      expect(FuelCounterUpper.fuel(mass: 14)).to eq(2)
    end
    it "finds 654 from 1969" do
      expect(FuelCounterUpper.fuel(mass: 1969)).to eq(654)
    end
    it "finds 33583 from 100756" do
      expect(FuelCounterUpper.fuel(mass: 100756)).to eq(33583)
    end
  end
  describe '.fuel2' do
    it "finds 2 from 12" do
      expect(FuelCounterUpper.fuel2(mass: 12)).to eq(2)
    end
    it "finds 2 from 14" do
      expect(FuelCounterUpper.fuel2(mass: 14)).to eq(2)
    end
    it "finds 966 from 1969" do
      expect(FuelCounterUpper.fuel2(mass: 1969)).to eq(966)
    end
    it "finds 33583 from 100756" do
      expect(FuelCounterUpper.fuel2(mass: 100756)).to eq(50346)
    end
  end
end
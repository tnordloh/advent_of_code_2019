image = File.readlines('input.txt')

image = image.pop.chomp.chars
image.map!(&:to_i)
p image.size
image_2 = []
while image.size > 0 do
  image_2 << image.pop(25*6)
end
p image_2[0]
p image_2.size
smallest = image_2.min_by { |i| i.select {|c| c == 0}.size }
p smallest
p smallest.select {|i| i == 1 }.size * smallest.select {|i| i == 2 }.size
stackle = image_2.transpose
p "equal?"
p image_2.map {|layer| layer[0] } == stackle[0]
final = stackle.map { |stack| stack.reverse.find {|c| c != 2} }
p final.size
#final.map! {|c| c == 0 ? "\u25A1": "\u25A0"}
p final.join
p ""
puts final.each_slice(25).map { |line| line.join }
  .join("\n")
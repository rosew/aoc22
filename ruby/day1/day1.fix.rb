
# Read the file
file = ARGV[0]
inputs = File.read(file)

elf_calories = inputs.split("\n\n").map do |elf|
  elf.split("\n").map!(&:to_i).inject(:+)
end

puts elf_calories.max
puts elf_calories.sort {|x,y| (y <=> x)}[0, 3].inject(:+)


# Read the file
file = ARGV[0]
lines = File.readlines(file).each(&:strip!)

elf_calories = lines.join("-").split("--").map do |elf|
  elf.split("-").map!(&:to_i).inject(:+)
end

puts elf_calories.max
puts elf_calories.sort {|x,y| (y <=> x)}[0, 3].inject(:+)

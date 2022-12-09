file = ARGV[0]
lines = File.readlines(file).each(&:strip!)

def get_values(line)
  line.split(',')
      .map { |range| range.split("-").map(&:to_i) }
      .flatten
end

def part1(lines)
  puts lines.filter { |line|
    e1_min, e1_max, e2_min, e2_max = get_values(line)
    ((e1_min <= e2_min) && (e1_max >= e2_max)) ||
    ((e1_min >= e2_min) && (e1_max <= e2_max))
  }.count
end

def part2(lines)
  puts lines.filter { |line|
    e1_min, e1_max, e2_min, e2_max = get_values(line)
    ((e1_max >= e2_min) && (e1_min <= e2_max)) ||
    ((e1_max <= e2_min) && (e1_min >= e2_max))
  }.count
end

part1 lines
part2 lines

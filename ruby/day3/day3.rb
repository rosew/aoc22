file = ARGV[0]
lines = File.readlines(file).each(&:strip!)

def priority(c)
  if c > "Z"
    c.ord - "a".ord + 1
  else
    c.ord - "A".ord + 27
  end
end

def part1(lines)
  puts lines.inject(0) { |sum, line|
    c1,c2 = line.split('').each_slice(line.length/2).to_a
    shared = c1 & c2
    sum + shared.map { |c| priority(c) }.inject(0, :+)
  }
end

def part2(lines)
  puts lines.each_slice(3).to_a.inject(0) { |sum, group|
    l1,l2,l3 = group.map { |line| line.split('') }
    badge = (l1 & l2 & l3).first
    sum + priority(badge)
  }
end

part2(lines)

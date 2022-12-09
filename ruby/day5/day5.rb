class Solver
  attr_accessor :lines, :stacks

  def initialize(file)
    @lines = File.readlines(file)
    @stacks = []
  end

  def move(num, from, to)
#    @stacks[to].push *@stacks[from].pop(num).reverse
    @stacks[to].push *@stacks[from].pop(num)
  end

  def add_to_stack(line)
    line.each_char.with_index do |ch, index|
      next unless (index%4) == 1 && ch.match?(/[A-Z]/)
      stack_num = 1 + index/4
      stacks[stack_num] ||= []
      stacks[stack_num].unshift ch
    end
  end

  def final_state
    @stacks[1..9].map { |stack| stack.last }.join("")
  end

  def part1
    lines.each do |line|
      match = /move (\d+) from (\d+) to (\d+)/.match line
      if match
        move(*match[1..3].map{ |c| c.to_i })
      else
        add_to_stack(line)
      end
    end
    final_state
  end
end

solver = Solver.new ARGV[0]
puts solver.part1

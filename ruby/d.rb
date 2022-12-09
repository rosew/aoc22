class Solver
  attr_accessor :lines, :stacks

  def initialize(file)
    @lines = File.readlines(file).each(&:strip!)
  end

  def part1
  end

  def part2
  end
end

solver = Solver.new ARGV[0]
puts solver.part1
puts solver.part2

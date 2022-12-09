class Solver
  attr_accessor :lines, :directory_sizes, :depth

  TOTAL_DISK = 70000000
  NEEDED = 30000000

  def initialize(file)
    @lines = File.readlines(file).each(&:strip!)
    @directory_sizes = { "/" => 0}
    @depth = []
  end

  def part1
    @lines.each do |line|
      if line == "$ cd /"
        @depth = ["/"]
      elsif line == "$ cd .."
        @depth.pop
      elsif line.start_with? "$ cd"
        dir_name = @depth.last + "/" + line.gsub("$ cd ", "")
        @depth << dir_name
        @directory_sizes[dir_name] = 0
      else
        size = line.to_i
        @depth.each do |dir|
          @directory_sizes[dir] += size
        end
      end
    end

    @directory_sizes.select { |name, size| size <= 100000 }.values.sum
  end

  def part2
    space_needed = NEEDED - (TOTAL_DISK - @directory_sizes["/"])
    @directory_sizes.select { |name, size| size >= space_needed }.values.min
  end
end

solver = Solver.new ARGV[0]
puts solver.part1
puts solver.part2

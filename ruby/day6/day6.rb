class Solver
  attr_accessor :line

  def initialize(file)
    @line = File.readlines(file).first
  end

  def part1(start_length)
    stream = line.chars.to_a
    stream.each_with_index do |_ch, index|
      if stream[index, start_length].uniq.length == start_length
        return index + start_length
      end
    end
  end
end

solver = Solver.new ARGV[0]
puts solver.part1 4
puts solver.part1 14

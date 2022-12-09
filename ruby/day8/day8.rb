class Solver
  attr_accessor :trees, :hidden

  ROW = 0
  COL = 1
  REVERSE = -1
  FORWARD = 1

  def initialize(file)
    lines = File.readlines(file).each(&:strip!)
    @max = lines.length

    @trees = {}
    @hidden = {}
    lines.each_with_index do |line, row|
      line.split("").each_with_index do |item, column|
        @trees[[row, column]] = item.to_i
        @hidden[[row, column]] = 0
      end
    end
  end

  def debug(data_trees)
    @max.times do |row|
      @max.times do |column|
        print data_trees[[row,column]]
      end
      puts ""
    end
  end

  def mark_hidden(check, incr, direction)
    outer_range = (0...@max).to_a

    key = []
    outer_range.each do |num|
      max_height = 0
      key[check] = num

      inner_range = direction  == FORWARD ? outer_range : outer_range.reverse
      inner_range.each_with_index do |num2, index|
        key[incr] = num2
        if index == 0
          max_height = @trees[key]
        elsif @trees[key] <= max_height
          @hidden[key] += 1
        else
          max_height = @trees[key] if @trees[key] > max_height
        end
      end
    end
  end

  def part1
    mark_hidden(ROW, COL, FORWARD)
    mark_hidden(ROW, COL, REVERSE)
    mark_hidden(COL, ROW, FORWARD)
    mark_hidden(COL, ROW, REVERSE)
    @hidden.values.select { |item| item != 4 }.count
  end

  def count_views(start_key, incr, direction)
    views = 0
    count = direction == FORWARD ? @max - start_key[incr] - 1 : start_key[incr]
    alt_key = start_key.dup
    count.times do
      views += 1
      alt_key[incr] += direction
      return views if @trees[start_key] <= @trees[alt_key]
    end
    views
  end

  def part2
    score = {}
    (1...@max-1).each do |row|
      (1...@max-1).each do |col|
        key = [row, col]
        score[key] =
          count_views(key, ROW, FORWARD) *
          count_views(key, ROW, REVERSE) *
          count_views(key, COL, FORWARD) *
          count_views(key, COL, REVERSE)
      end
    end
    score.values.max
  end
end

solver = Solver.new ARGV[0]
puts solver.part1
puts solver.part2

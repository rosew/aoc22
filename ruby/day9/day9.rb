class Solver
  X = 0
  Y = 1

  def initialize(file)
    @directions = File.readlines(file).map do |line|
      direction_str, count_str = line.split
      direction = { line: line, count: count_str.to_i }
      direction[:change] = ["U", "D"].include?(direction_str) ? Y : X
      direction[:change_alt] = ["U", "D"].include?(direction_str) ? X : Y
      direction[:direction] = ["U", "R"].include?(direction_str) ? 1 : -1
      direction
    end
    @locations = []
    @tail_locations = {}
  end

  def part1
    head_location = [0, 0]
    tail_location = [0, 0]
    tail_locations = { tail_location => true }
    @directions.each do |direction|
      direction[:count].times do
        head_location[direction[:change]] += direction[:direction]
        if (head_location[direction[:change]] - tail_location[direction[:change]]).abs > 1
          if (head_location[direction[:change_alt]] - tail_location[direction[:change_alt]]).abs > 0
            tail_location[direction[:change_alt]] = head_location[direction[:change_alt]]
          end
          tail_location[direction[:change]] += direction[:direction]
          tail_locations[tail_location] = true
        end
      end
    end
    tail_locations.count
  end

  def tug_on_rope_from(location_num, direction, number_of_locations)
    return if location_num == number_of_locations - 1
    loc = @locations[location_num]
    next_loc = @locations[location_num + 1]
    x_diff = loc[X] - next_loc[X]
    y_diff = loc[Y] - next_loc[Y]

    return if x_diff.abs <= 1 && y_diff.abs <= 1

    if x_diff.abs > 1
      next_loc[Y] += (y_diff > 0 ? 1 : -1) if y_diff.abs > 0
      next_loc[X] += (x_diff > 0 ? 1 : -1)
    else
      next_loc[X] += (x_diff > 0 ? 1 : -1) if x_diff.abs > 0
      next_loc[Y] += (y_diff > 0 ? 1 : -1)
    end

    if location_num + 1 == number_of_locations - 1
      @tail_locations[next_loc.dup] = true
    else
      tug_on_rope_from(location_num + 1, direction, number_of_locations)
    end
  end

  def part2(number_of_locations)
    number_of_locations.times { |i| @locations << [0, 0] }
    @tail_locations = { @locations[number_of_locations - 1] => true }
    @directions.each do |direction|
      direction[:count].times do
        @locations[0][direction[:change]] += direction[:direction]
        tug_on_rope_from(0, direction, number_of_locations)
      end
    end
    @tail_locations.count
  end
end

solver = Solver.new ARGV[0]
puts solver.part1 # OR solver.part2 2
puts solver.part2 10

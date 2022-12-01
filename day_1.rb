def read_input
  highest_calories = 0

  sums = []

  accumulator = 0
  File.readlines('/Users/XSM898/Desktop/day_1_input.txt').each do |line|
    if line.to_s.strip.empty?
      sums.push(accumulator)
      accumulator = 0
    else
      accumulator += line.to_i
    end
  end

  sums.sort!.reverse!

  puts 'Top 3 highest_calories'
  puts [sums[0], sums[1], sums[2]].sum
end

read_input

# frozen_string_literal: true

sums = []

accumulator = 0

File.readlines("#{Dir.getwd}/day_1_rb/day_1_input.txt").each do |line|
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

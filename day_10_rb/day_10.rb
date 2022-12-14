# !/usr/bin/ruby
# frozen_string_literal: true

def cycle_check(cycle_num, reg, strength)
  return strength unless cycle_num == 20 || ((cycle_num + 20) % 40).zero?

  cycle_strength = cycle_num.to_i * reg.to_i
  new_strength = cycle_strength.to_i + strength.to_i
  puts "cycle: #{cycle_num} || Strength: #{cycle_strength} || Strength Sum: #{new_strength}"

  new_strength
end

def check_draw_pixel(cycle_num, reg)
  pixel = cycle_num % 40
  return false unless pixel.between?((reg - 1), (reg + 1))

  true
end

def read_file(path)
  lines = []

  File.readlines("#{__dir__}#{path}").each do |line|
    line = line.to_s.strip
    lines << line
  end

  lines
end

file_path = '/input.txt'
# file_path = '/demo.txt'

register = 1
cycle = 0

strength_sum = 0

lines = read_file(file_path)

drawing = String.new

lines.each do |line|
  cycle += 1

  strength_sum = cycle_check(cycle, register, strength_sum)

  draw = check_draw_pixel(cycle, register)
  drawing += draw ? '#' : ' '

  next unless line.start_with?('addx')

  cycle += 1

  strength_sum = cycle_check(cycle, register, strength_sum)

  register += line.split(' ')[1].to_i

  draw = check_draw_pixel(cycle, register)
  drawing += draw ? '#' : ' '
end

puts drawing.chars.each_slice(40).map(&:join)

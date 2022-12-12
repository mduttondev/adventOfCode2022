# !/usr/bin/ruby
# frozen_string_literal: true

class Monkey
  attr_accessor :items, :operation, :operation_value, :test_divisor, :test_positive_monkey, :test_neg_monkey

  def initialize(items, operation, operation_value, test_divisor, test_positive_monkey, test_neg_monkey)
    @items = items
    @operation = operation
    @operation_value = operation_value
    @test_divisor = test_divisor
    @test_positive_monkey = test_positive_monkey
    @test_neg_monkey = test_neg_monkey
  end
end

seperate_objects = []

# file_name = 'demo'
file_name = 'input'

monkey_string = String.new
file = File.readlines("#{__dir__}/#{file_name}.txt")
file.each do |line|
  monkey_string << line
  if line.strip.empty? || line == file.last
    seperate_objects.push(monkey_string)
    monkey_string = String.new
  end
end

all_monkeys = []

seperate_objects.each do |object|
  items = []
  operation = -> {}
  op_value = String.new
  divisor = 0
  true_monkey = -1
  false_monkey = -1

  object.split("\n").each do |line|
    next if line.start_with?('Monkey')

    parts = line.split(': ').map(&:strip)

    if parts[0].start_with?('Starting')
      parts[1].split(',').map(&:strip).each { |item| items.push(item.to_i) }
    elsif parts[0].start_with?('Operation')
      op = parts[1].split('= ')[1]
      operation = if op.include?('+')
                    ->(old, val) { return old + val }
                  else
                    ->(old, val) { return old * val }
                  end
      op_value = op.split.last
    elsif parts[0].start_with?('Test')
      divisor = parts[1].split.last.to_i
    elsif parts[0].start_with?('If true')
      true_monkey = parts[1].split.last.to_i
    elsif parts[0].start_with?('If false')
      false_monkey = parts[1].split.last.to_i
    end
  end
  all_monkeys.push(Monkey.new(items, operation, op_value, divisor, true_monkey, false_monkey))
end

inspections = {}
big_mod = 1
all_monkeys.each_with_index do |mon, i|
  inspections[i] = 0
  big_mod *= mon.test_divisor
end

10_000.times do
  all_monkeys.each_with_index do |monkey, idx|
    monkey.items.each do |item|
      inspections[idx] += 1
      val = monkey.operation_value == 'old' ? item : monkey.operation_value.to_i
      new_value = monkey.operation.call(item, val) % big_mod
      test = (new_value % monkey.test_divisor).zero?
      if test
        pos = monkey.test_positive_monkey
        all_monkeys[pos].items.push(new_value)
      else
        neg = monkey.test_neg_monkey
        all_monkeys[neg].items.push(new_value)
      end
    end
    monkey.items = []
  end
end

puts inspections
puts inspections.values.sort.reverse.first(2).inject(:*)

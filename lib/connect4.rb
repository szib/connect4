require 'remedy'
require './lib/grid.rb'

include Remedy

slot = Interaction.new
grid = Grid.new
puts grid.print

slot.loop do |key|
  exit if key.to_s.casecmp('q').zero?

  puts 'Which slot? (1-7, q for quit) ==> ' unless grid.having_a_winner?
  grid.insert_coin(key.value.to_i - 49) if key.value.to_i.between?(49, 55)
  puts grid.print
  break if grid.full? || grid.having_a_winner?
end

if grid.having_a_winner?
  puts "The winner is: #{grid.marks[grid.winner]}"
else
  puts "It's a draw." unless grid.having_a_winner?
end

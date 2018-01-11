require './lib/grid.rb'

grid = Grid.new
puts grid.print

until grid.full? || grid.having_a_winner?
  puts 'Which slot? (1-7, q for quit) ==> ' unless grid.having_a_winner?
  slot = gets.chomp
  exit if slot.downcase == 'q'
  grid.insert_coin(slot.to_i-1)
  puts grid.print
end

if grid.having_a_winner?
  puts "The winner is: #{grid.marks[grid.winner]}"
else
  puts "It's a draw." unless grid.having_a_winner?
end

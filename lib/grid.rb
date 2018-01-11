require './lib/column.rb'

class Grid
  attr_reader :grid, :winner, :turn, :marks

  def initialize(marks = ['.', 'X', 'O'])
    @grid = []
    7.times do
      @grid.push(Column.new)
    end
    @marks = marks
    @winner = nil
    @turn = 0
  end

  def insert_coin(col)
    return nil if col.class != Integer || !@winner.nil?
    return nil unless col.between?(0, 6)
    player = @turn.even? ? 1 : 2
    row = @grid[col].insert_coin(player)
    return nil if row.nil?
    @turn += 1
    @winner = player if possible_fours(col, row).any? { |x| x =~ /#{player.to_s * 4}/ }
    [col, row]
  end

  def full?
    (to_s =~ /0/).nil?
  end

  def having_a_winner?
    !@winner.nil?
  end

  def get_coin(row, col)
    @grid[col].coins[row]
  end

  def possible_fours(col, row)
    return nil if col.class != Integer || row.class != Integer
    if col.between?(0, 6) && row.between?(0, 7)
      fours = []
      diagonal = []
      antidiagonal = []

      fours.push(@grid[col].to_s)
      fours.push(@grid.collect { |x| x.coins[row] }.join)

      (-3..+3).each do |offset|
        diagonal.push([row + offset, col + offset])
        antidiagonal.push([row + offset, col + offset * -1])
      end
      diagonal.select! { |x| x[0].between?(0, 5) && x[1].between?(0, 6) }
              .map! { |x| get_coin(x[0], x[1]) }
      antidiagonal.select! { |x| x[0].between?(0, 5) && x[1].between?(0, 6) }
                  .map! { |x| get_coin(x[0], x[1]) }
      fours.push(diagonal.join)
      fours.push(antidiagonal.join)

      fours
    end
  end

  def display
    g = []
    6.times do |row|
      r = []
      7.times do |col|
        c = @grid[col].coins[row]
        r.push(c)
      end
      g.push("\t|#{r.join('|')}|")
    end
    g.reverse.join("\n")
  end

  def print
    puts "\n\nTurn: #{@turn + 1}\n"
    s = "\t|#{(1..7).map(&:to_s).join(' ')}|"
    puts s
    puts s.gsub(/\d/, ' ')
    puts display.gsub(/1/, @marks[1]).gsub(/2/, @marks[2]).gsub(/0/, @marks[0])
    puts "\t" + '-' * 15
    puts "\nNext player is #{@turn.odd? ? marks[1] : marks[2]}" if @winner.nil?
  end

  def to_a
    @grid.map(&:to_s)
  end
end

class Column
  attr_reader :coins

  def initialize
    @coins = Array.new(6, 0)
  end

  def insert_coin(player)
    return nil if full?
    idx = @coins.find_index(0)
    @coins[idx] = player
    idx
  end

  def full?
    @coins.find_index(0).nil?
  end

  def to_s(j = '')
    @coins.join(j)
  end

  def to_a
    @coins
  end
end

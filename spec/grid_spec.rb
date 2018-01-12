require './lib/grid.rb'

describe Grid do
  let(:empty_grid) do
    Grid.new
  end

  let(:grid_with_coins) do
    g = Grid.new
    g.insert_coin(5)
    g.insert_coin(5)
    g.insert_coin(4)
    g
  end

  let(:grid_with_a_full_row) do
    g = Grid.new
    (0..12).each { |x| g.insert_coin(x / 2) }
    g
  end

  let(:grid_with_a_full_col) do
    g = Grid.new
    6.times do
      g.insert_coin(0)
      g.insert_coin(1)
    end
    g
  end

  let(:grid_with_diagonal4) do
    g = Grid.new
    4.times do |x|
      4.times do |y|
        g.insert_coin(x + y)
      end
    end
    g
  end

  let(:full_grid_no_winner) do
    g = Grid.new
    [0, 1, 4, 5].each do |x|
      6.times { g.insert_coin(x) }
    end
    g.insert_coin(6)
    6.times { g.insert_coin(3) }
    6.times { g.insert_coin(2) }
    5.times { g.insert_coin(6) }
    g
  end

  describe '#initialize' do
    it 'creates a Grid instance' do
      expect(empty_grid).to be_instance_of Grid
      expect(empty_grid.grid).to be_instance_of Array
    end
  end

  describe '#insert_coin' do
    it 'works with valid arguments' do
      expect(empty_grid.insert_coin(3)).to match([3, 0])
      expect(empty_grid.insert_coin(4)).to match([4, 0])
    end
    it 'fails with invalid arguments' do
      expect(empty_grid.insert_coin('3')).to be_nil
      expect(empty_grid.insert_coin(7)).to be_nil
    end
  end

  describe '#full?' do
    it 'returns false if it\'s not full' do
      expect(empty_grid).not_to be_full
      expect(grid_with_coins).not_to be_full
    end
    it 'returns true if it\'s full' do
      expect(full_grid_no_winner).to be_full
    end
  end

  describe '#to_a' do
    it 'returns an Array' do
      expect(empty_grid.to_a).to be_instance_of Array
    end
  end

  describe '#to_s' do
    it 'returns a String' do
      expect(empty_grid.to_s).to be_instance_of String
    end
  end

  describe '#possible_fours' do
    context 'with invalid arguments' do
      it 'returns nil' do
        expect(empty_grid.possible_fours(4, 8)).to be_nil
        expect(empty_grid.possible_fours(7, 3)).to be_nil
        expect(empty_grid.possible_fours('3', 4)).to be_nil
        expect(empty_grid.possible_fours(3, '4')).to be_nil
      end
    end

    context 'with empty grid' do
      it 'returns an Array' do
        expect(empty_grid.possible_fours(4, 3)).to be_instance_of Array
      end
      it 'everything is 0' do
        r = empty_grid.possible_fours(4, 3).join
        expect(r).to match(/^0*$/)
      end
    end

    context 'with having four in a row' do
      it 'returns an all 2 row' do
        r = grid_with_a_full_row.possible_fours(0, 0)
        expect(r).to include('1111000')
      end
    end
    context 'with having four in a column' do
      it 'returns an all 1 column' do
        r = grid_with_a_full_col.possible_fours(0, 0)
        expect(r).to include('111100')
      end
    end

    context 'with having a diagonal four' do
      it 'returns the expected diagonal string' do
        r = grid_with_diagonal4.possible_fours(0, 0)
        r2 = grid_with_diagonal4.possible_fours(3, 3)
        r3 = grid_with_diagonal4.possible_fours(1, 1)
        expect(r).to be_instance_of Array
        expect(r).to include('1111')
        expect(r2).to include('111100')
        expect(r3).to include('11110')
      end
    end
  end

  describe '#having_a_winner?' do
    it 'no winner' do
      expect(empty_grid).to_not be_having_a_winner
    end
    it 'has a winner' do
      expect(grid_with_a_full_col).to be_having_a_winner
      expect(grid_with_a_full_row).to be_having_a_winner
      expect(grid_with_diagonal4).to be_having_a_winner
    end
  end
end

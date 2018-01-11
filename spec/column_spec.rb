require './lib/grid.rb'

describe Column do
  let(:empty_column) do
    Column.new
  end

  let(:half_empty_column) do
    l = Column.new
    3.times { l.insert_coin(1) }
    l
  end

  let(:full_column) do
    l = Column.new
    6.times { l.insert_coin(1) }
    l
  end

  describe '#initialize' do
    it 'creates an empty column' do
      expect(empty_column).to be_instance_of Column
    end

    it 'it has only empty fields' do
      expect(empty_column.coins).to all(be == 0)
    end
  end

  describe '#full?' do
    context 'with full column' do
      it 'returns true' do
        expect(full_column).to be_full
      end
    end

    context 'with not full column' do
      it 'returns false' do
        expect(half_empty_column).not_to be_full
        expect(empty_column).not_to be_full
      end
    end
  end

  describe '#insert_coin' do
    context 'with full column' do
      it 'returns nil' do
        expect(full_column.insert_coin('X')).to be_nil
      end
    end

    context 'with not full column' do
      it 'returns the number of row where the coin fell' do
        expect(half_empty_column.insert_coin('O')).to be_between(0, 5).inclusive
        expect(empty_column.insert_coin('O')).to be_between(0, 5).inclusive
      end
    end
  end

  describe '#to_s' do
    it 'returns a string' do
      expect(empty_column.to_s).to be_instance_of String
    end
    it 'returns correct string' do
      expect(empty_column.to_s).to eql('000000')
      expect(half_empty_column.to_s).to eql('111000')
      expect(full_column.to_s).to eql('111111')
    end
  end
end

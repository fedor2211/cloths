require 'cloth'

describe 'Cloth' do
  let(:cloth) do
    Cloth.new(name: 'Hat', category: 'headgear', temp_range: 10..25)
  end

  describe 'suites_for_temp?' do
    it 'returns true' do
      expect(cloth.suits_for_temp?(25)).to be_truthy
    end

    it 'returns false' do
      expect(cloth.suits_for_temp?(9)).to be_falsey
    end
  end

  describe 'to_s' do
    it 'returns "Hat (headgear) 10..25"' do
      expect(cloth.to_s).to eq 'Hat (headgear) 10..25'
    end
  end
end

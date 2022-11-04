require 'cloth_collection'

describe 'ClothCollection' do
  let(:cloth_collection) do
    files = Dir[File.join(__dir__, 'fixtures', 'clothes', '*.txt')]
    ClothCollection.from_files(files)
  end

  describe 'by_category' do
    let(:cloths_by_categories) do
      cloth_collection.categories.map do |category|
        cloth_collection.by_category(category)
      end
    end

    it 'returns true (cloths categories sets not empty)' do
      cloths_by_categories.each do |cloth_set|
        expect(cloth_set).not_to be_empty
      end
    end

    it 'returns true (cloths categories equal)' do
      cloths_by_categories.each do |cloth_set|
        expect(
          cloth_set.map(&:category).uniq.size
        ).to eq 1
      end
    end
  end

  describe 'cloth_set_for_temp' do
    let(:cloth_sets) do
      [-20, -8, 15, 20].map do |temp|
        [temp, cloth_collection.cloth_set_for_temp(temp)]
      end
    end

    it 'returns true (cloth sets not empty)' do
      cloth_sets.each do |cloth_set|
        expect(cloth_set).not_to be_empty
      end
    end

    it 'returns true (cloths fit for temp)' do
      cloth_sets.each do |temp, cloth_set|
        expect(
          cloth_set.all? { |cloth| cloth.suits_for_temp?(temp) }
        ).to be_truthy
      end
    end

    it 'returns true (cloths categories different)' do
      cloth_sets.each do |_, cloth_set|
        categories = cloth_set.map(&:category)
        expect(
          categories.uniq
        ).to eq categories
      end
    end
  end
end

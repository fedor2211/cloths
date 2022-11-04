require 'cloth_collection'

describe ClothCollection do
  let(:cloth_collection) do
    files = Dir[File.join(__dir__, 'fixtures', 'clothes', '*.txt')]
    ClothCollection.from_files(files)
  end

  describe '#by_category' do
    let(:cloths_by_categories) do
      cloth_collection.categories.map do |category|
        cloth_collection.by_category(category)
      end
    end

    context 'when cloth sets are nonempty' do
      it 'returns true' do
        cloths_by_categories.each do |cloth_set|
          expect(cloth_set).not_to be_empty
        end
      end
    end

    context 'when all cloths in set has the same category' do
      it 'returns true' do
        cloths_by_categories.each do |cloth_set|
          expect(
            cloth_set.map(&:category).uniq.size
          ).to eq 1
        end
      end
    end
  end

  describe '#cloth_set_for_temp' do
    let(:cloth_sets) do
      [-20, -8, 15, 20].map do |temp|
        [temp, cloth_collection.cloth_set_for_temp(temp)]
      end
    end

    context 'when cloth sets are nonempty' do
      it 'returns true' do
        cloth_sets.each do |cloth_set|
          expect(cloth_set).not_to be_empty
        end
      end
    end

    context 'when cloths in set are suitable for temp' do
      it 'returns true' do
        cloth_sets.each do |temp, cloth_set|
          expect(
            cloth_set.all? { |cloth| cloth.suits_for_temp?(temp) }
          ).to eq true
        end
      end
    end

    context 'when each cloth in set has unique category' do
      it 'returns true' do
        cloth_sets.each do |_, cloth_set|
          categories = cloth_set.map(&:category)
          expect(
            categories.uniq
          ).to eq categories
        end
      end
    end
  end
end

require 'cloth'
require 'cloth_collection'

describe ClothCollection do
  let(:cloths_data) do
    [['Шерстяная шапка', 'Головной убор', -28..-5],
     ['Пуховик', 'Верхняя одежда', -28..-5],
     ['Сандали', 'Обувь', 20..40],
     ['Валенки', 'Обувь', -30..-5],
     ['Кепка', 'Головной убор', 10..40],
     ['Ветровка', 'Верхняя одежда', 5..20],
     ['Демисезонная куртка', 'Верхняя одежда', -5..5],
     ['Кроссовки', 'Обувь', -5..20],
     ['Джинсы', 'Штаны', -5..20],
     ['Льняные штаны', 'Штаны', 15..40],
     ['Утеплённые штаны', 'Штаны', -30..-5]]
  end
  let(:cloths) do
    cloths_data.map do |entry|
      Cloth.new(
        name: entry[0],
        category: entry[1],
        temp_range: entry[2]
      )
    end
  end
  let(:cloth_collection) do
    ClothCollection.new(cloths)
  end
  let(:categories) do
    ['Головной убор',
     'Верхняя одежда',
     'Обувь',
     'Штаны']
  end

  describe '.from_file' do
    let(:data_files) { Dir[File.join(__dir__, 'fixtures', 'clothes', '*.txt')] }

    it 'returns clothes from files' do
      expect(
        ClothCollection.from_files(data_files).to_s
      ).to eq cloth_collection.to_s
    end
  end

  describe '#categories' do
    it 'returns array of clothes categories in collection' do
      expect(
        cloth_collection.categories
      ).to eq categories
    end
  end
 
  describe '#by_category' do
    let(:by_category) { cloth_collection.by_category('Штаны') }
    let(:by_category_empty) { cloth_collection.by_category('') }

    context 'when collection has clothes with category' do
      it 'returns cloths with the same category' do
        expect(
          by_category.map(&:category).uniq.size
        ).to eq 1
      end
    end

    context 'when collection has no clothes with category' do
      it 'returns empty array' do
        expect(
          by_category_empty
        ).to be_empty
      end
    end
  end

  describe '#cloth_set_for_temp' do
    let(:cloth_set) do
      cloth_collection.cloth_set_for_temp(0)
    end
    let(:cloth_set_empty) do
      cloth_collection.cloth_set_for_temp(-50)
    end

    context 'when collection has clothes suitable for temp' do
      it 'all clothes are suitable for temp' do
        expect(
          cloth_set.all? { |cloth| cloth.suits_for_temp?(0) }
        ).to eq true
      end

      it 'all clothes has unique category' do
        expect(
          cloth_set.map(&:category).uniq
        ).to eq cloth_set.map(&:category) 
      end
    end

    context 'when collection has no clothes suitable for temp' do
      it 'returns empty array' do
        expect(
          cloth_set_empty
        ).to be_empty
      end
    end
  end
end

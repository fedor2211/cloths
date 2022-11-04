require_relative 'cloth'

class ClothCollection
  attr_reader :categories

  def self.from_files(files)
    cloths = files.map do |file|
      cloth_data = File.readlines(file, chomp: true)
      low, high = cloth_data[2].scan(/[+-]?\d+/).first(2).map(&:to_i)
      Cloth.new(
        name: cloth_data[0],
        category: cloth_data[1].to_sym,
        temp_range: low..high
      )
    end
    new(cloths)
  end

  def initialize(cloths)
    @cloths = cloths
    @categories = @cloths.map(&:category).uniq
  end

  def by_category(category)
    @cloths.select { |cloth| cloth.category == category }
  end

  def cloth_set_for_temp(temp)
    @categories.map do |category|
      by_category(category)
        .filter_map { |cloth| cloth if cloth.suits_for_temp?(temp) }
        .sample
    end
  end
end

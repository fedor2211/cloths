require_relative 'cloth'

class ClothCollection
  attr_reader :categories

  def self.from_files(files)
    cloths = files.map do |file|
      cloth_data = File.readlines(file, chomp: true)
      low, high = cloth_data[2].scan(/[+-]?\d+/).first(2).map(&:to_i)
      Cloth.new(
        name: cloth_data[0],
        category: cloth_data[1],
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
    @categories.filter_map do |category|
      by_category(category)
        .select { |cloth| cloth.suits_for_temp?(temp) }
        .sample
    end
  end
  
  def to_s
    @cloths.map(&:to_s)
  end
end

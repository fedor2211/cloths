class Cloth
  attr_reader :category

  def initialize(params)
    @name = params[:name]
    @category = params[:category]
    @temp_range = params[:temp_range]
  end

  def suits_for_temp?(temp)
    @temp_range.include?(temp)
  end

  def to_s
    "#{@name} (#{@category}) #{@temp_range}"
  end
end

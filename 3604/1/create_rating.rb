# class for create rating
class CreateRating
  attr_reader :array_gems

  ARRAY_COEFFICIENT = [1, 0.5, 1, 0.7, 0.5, 0.1].freeze

  def initialize(array_gems)
    @array_gems = array_gems
  end

  def rating_of_gems
    array_gems.sort_by { |gem| - gem_rating(gem, gem.size) }
  end

  private

  def gem_rating(array, array_size)
    sum = 0
    (array_size - 1).times do |iter|
      sum += array[iter + 1].gsub(/[,]/, '').to_i * ARRAY_COEFFICIENT[iter]
    end
    sum
  end
end

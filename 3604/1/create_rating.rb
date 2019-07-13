# class for create rating
class CreateRating
  def initialize(array_gems)
    @array_gems = array_gems
    @array_coefficient = [1, 0.5, 1, 0.7, 0.5, 0.1]
  end

  def create_rating
    priority_counting
    sort_by_value
    @array_gems
  end

  private

  def priority_counting
    @array_gems.each do |arr|
      array_size = arr.size
      arr << sum(arr, array_size)
    end
  end

  def sum(array, array_size)
    sum = 0
    (array_size - 1).times do |iter|
      sum += array[iter + 1].gsub(/[^0-9]/, '').to_i * @array_coefficient[iter]
    end
    sum
  end

  def sort_by_value
    @array_gems.sort_by!(&:last)
    @array_gems.reverse!
    @array_gems.each(&:pop)
  end
end

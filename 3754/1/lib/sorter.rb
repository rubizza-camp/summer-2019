# Class for storing stats about gems
class Sorter
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def sort_data
    data.sort_by! { |element| element[1] }.reverse!
  end
end

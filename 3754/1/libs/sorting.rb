# class for sorting gems list
class Sorting
  def initialize(data)
    @data = data
  end

  def sort
    @data.sort_by! { |element| element[1] }.reverse!
  end
end

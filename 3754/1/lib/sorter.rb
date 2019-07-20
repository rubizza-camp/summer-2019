# Class for storing stats about gems
class Sorter
  def self.sort_data(data)
    new.sort_data(data)
  end

  def sort_data(data)
    data.sort_by! { |element| element[1] }.reverse!
  end
end

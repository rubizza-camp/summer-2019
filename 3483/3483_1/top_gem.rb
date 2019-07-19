require_relative 'output'

class TopGem
  def call(array_of_hash)
    take_points(array_of_hash)
    array_with_top = array_of_hash.sort_by { |hash| hash[:points].to_i }.reverse
    Output.call(array_with_top)
  end

  private

  def take_points(array_of_hash)
    array_of_hash.each do |elem|
      elem[:points] = " #{elem[:star].to_i *
                          elem[:watch].to_i *
                          elem[:fork].to_i}  Points"
    end
  end
end

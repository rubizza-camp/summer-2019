require_relative 'output'

class TopGem
  def call(gems)
    count_rating(gems)
    sorted_gems = gems.sort_by { |hash| hash[:points].to_i }.reverse
    Output.call(sorted_gems)
  end

  private

  def count_rating(gems)
    gems.each do |elem|
      elem[:points] = " #{elem[:star].to_i *
                          elem[:watch].to_i *
                          elem[:fork].to_i}  Points"
    end
  end
end

require_relative 'output'

class TopGem
  def call(gems)
    count_rating(gems)
    sorted_gems = gems.sort_by { |hash| hash[:points].to_i }.reverse
    Output.call(sorted_gems)
  end

  private

  def count_rating(gems)
    gems.each do |gem_stat|
      gem_stat[:points] = " #{gem_stat[:star].to_i *
                              gem_stat[:watch].to_i *
                              gem_stat[:fork].to_i}  Points"
    end
  end
end

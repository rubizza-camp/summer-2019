require_relative 'output'

class TheBestGem
  def call(array_of_hash)
    take_points(array_of_hash)
    array_with_top = array_of_hash.sort_by { |hash| hash['Points:'].to_i }.reverse
    fetch_output = Output.new
    fetch_output.output(array_with_top)
  end

  private

  def take_points(array_of_hash)
    (0...array_of_hash.size).each do |elem|
      array_of_hash[elem]['Points:'] = " #{array_of_hash[elem]['Star:'].to_i *
                                           array_of_hash[elem]['Watch:'].to_i *
                                           array_of_hash[elem]['Fork:'].to_i}  Points"
    end
  end
end

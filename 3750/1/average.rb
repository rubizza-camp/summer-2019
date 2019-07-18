class Average
  class << self
    def calculate_average_stats(gem_array)
      {
        used:          average_in_float(gem_array, :used),
        forks:         average_in_float(gem_array, :forks),
        stars:         average_in_float(gem_array, :stars),
        contributors:  average_in_float(gem_array, :contributors),
        watched:       average_in_float(gem_array, :watched),
        issues:        average_in_float(gem_array, :issues)
      }
    end

    private

    def average_in_float(gem_array, key)
      sum = (gem_array.map { |gem| gem.stats[key].scan(/\d/).join('').to_f }).sum
      sum / gem_array.size
    end
  end
end

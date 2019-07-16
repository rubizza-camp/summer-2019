# class for create rating
class RatingCreator
  HASH_COEFFICIENTS = {
    used_by: 1,
    watched_by: 0.5,
    stars: 1,
    forks: 0.7,
    contributors: 0.5,
    issues: 0.1
  }.freeze

  def array_of_rating_gems(array_of_all_gems)
    array_of_all_gems.sort_by { |hash_of_one_gem| -sum_of_gem(hash_of_one_gem) }
  end

  private

  def sum_of_gem(hash_of_one_gem)
    hash_of_one_gem = hash_of_one_gem.map do |key, value|
      value.gsub(/[,]/, '').to_i * HASH_COEFFICIENTS[key] if HASH_COEFFICIENTS[key]
    end
    hash_of_one_gem.shift # first value nil, because it's gem_name
    hash_of_one_gem.sum
  end
end

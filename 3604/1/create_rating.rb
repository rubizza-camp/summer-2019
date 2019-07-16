# class for create rating
class CreateRating
  ARRAY_COEFFICIENT = {
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
    sum = 0
    hash_of_one_gem.each do |key, value|
      sum += value.gsub(/[,]/, '').to_i * ARRAY_COEFFICIENT[key] if ARRAY_COEFFICIENT[key]
    end
    sum
  end
end

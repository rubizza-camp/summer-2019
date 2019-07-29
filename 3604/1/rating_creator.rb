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

  def reoder_gems_by_rating(array_of_all_gems)
    array_of_all_gems.sort_by { |hash_of_one_gem| -rating_of_gem(hash_of_one_gem) }
  end

  private

  def rating_of_gem(hash_of_one_gem)
    HASH_COEFFICIENTS.map do |key, value|
      value * hash_of_one_gem[key].gsub(/[,]/, '').to_i
    end.sum
  end
end

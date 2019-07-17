module ScoreMethods
  INCREASED_COEF = 3
  NORMAL_COEF = 2
  REDUCED_COEF = 1

  def group_score(gem_hash)
    score = {}
    gem_hash.each do |key, value|
      score[key] = calculate_score(value.slice(:count_used_by, :count_watched, :count_stars,
                                               :count_forks, :count_contributors, :count_issues))
    end
    score
  end

  private

  def calculate_score(gem_hash)
    INCREASED_COEF * gem_hash[:count_used_by] +
      NORMAL_COEF * gem_hash[:count_watched] * gem_hash[:count_stars] * gem_hash[:count_forks] +
      REDUCED_COEF * gem_hash[:count_contributors] * gem_hash[:count_issues]
  end
end

class AnalyzerGems
  def initialize(hash_with_stats)
    @hash_with_stats = hash_with_stats
  end

  COEFFICIENT = {
    used_by: 0.7,
    watch: 0.5,
    star: 1,
    fork: 1,
    contributors: 0.5,
    issues: 0.3
  }.freeze

  def score_of_gems
    @hash_with_stats.map do |key, value|
      value * COEFFICIENT[key]
    end.sum
  end
end

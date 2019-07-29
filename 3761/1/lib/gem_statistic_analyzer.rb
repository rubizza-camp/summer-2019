class GemStatisticAnalyzer
  RATIO = {
    used_by: 0.9,
    watch: 0.8,
    star: 1,
    fork: 0.85,
    contributors: 0.75,
    issues: 0.75
  }.freeze

  def self.call(stats)
    RATIO.inject(0) do |score, (hash_key, hash_value)|
      score + hash_value * stats[hash_key].to_i
    end
  end
end

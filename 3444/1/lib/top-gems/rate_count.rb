# This class set :rate value into each hash with stats,
# cause of that you can sort by :rate and set up any coefficients
# for stats you want.
module TopGems
  class RateCount
    def self.call(stats)
      weights = { stars: 2, watched_by: 3, issues: -100 }
      weights.map { |field, weight| stats[field] * weight }.sum
    end
  end
end

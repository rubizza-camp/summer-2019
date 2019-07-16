require_relative 'gemy'
require_relative 'average'

class Score
  class << self
    def calculate_overall_score(gem)
      overall_score = 0
      gem.scores.values.each do |value|
        overall_score += value
      end
      overall_score
    end

    def calculate_score_for_each_stat(gem, average)
      {
        used:         stat_score(:used, gem, average),
        forks:        stat_score(:forks, gem, average),
        stars:        stat_score(:stars, gem, average),
        contributors: stat_score(:contributors, gem, average),
        watched:      stat_score(:watched, gem, average)
      }
    end

    private

    def stat_score(key, gem, average)
      gem.stats[key].scan(/\d/).join('').to_f / average[key]
    end
  end
end

class Score
  class << self
    def calculate_overall_score(scores)
      scores.values.sum
    end

    def calculate_score_for_each_stat(average, stats)
      {
        used:         stat_score(:used, average, stats),
        forks:        stat_score(:forks, average, stats),
        stars:        stat_score(:stars, average, stats),
        contributors: stat_score(:contributors, average, stats),
        watched:      stat_score(:watched, average, stats)
      }
    end

    private

    def stat_score(key, average, stats)
      stats[key].scan(/\d/).join('').to_f / average[key]
    end
  end
end

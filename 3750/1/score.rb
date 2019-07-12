require_relative 'gemy'

class Score
  def initialize(gem_array)
    @gem_array = gem_array
  end

  attr_reader :average_stats

  def calculate_overall_score
    calculate_score_for_each_stat
    @gem_array.each do |gem|
      gem.scores.values.each do |x|
        gem.overall_score += x
      end
    end
  end

  private

  def average(key)
    sum = 0
    @gem_array.each do |gem|
      sum += (gem.stats[key].delete!',').to_f
    end
    sum / @gem_array.size
  end

  def calculate_average_stats
    @average_stats ||= {
      average_used:          average(:used),
      average_forks:         average(:forks),
      average_stars:         average(:stars),
      average_contributors:  average(:contributors),
      average_watched:       average(:watched),
      average_issues:        average(:issues)
    }
  end

  def calculate_score_for_each_stat
    calculate_average_stats
    @gem_array.each do |gem|
      gem.scores = {
        used_score:         gem.stats[:used].to_f / @average_stats[:average_used],
        forks_score:        gem.stats[:forks].to_f / @average_stats[:average_forks],
        stars_score:        gem.stats[:stars].to_f / @average_stats[:average_stars],
        contributors_score: gem.stats[:contributors].to_f / @average_stats[:average_contributors],
        # issues_score:       gem.stats[:issues].to_f / @average_stats[:average_issues],
        watched_score:      gem.stats[:watched].to_f / @average_stats[:average_watched]
      }
    end
  end
end
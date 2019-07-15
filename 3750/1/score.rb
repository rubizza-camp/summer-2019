require_relative 'gemy'

class Score
  def initialize(gem_array)
    @gem_array = gem_array
  end

  def calculate_scores
    calculate_score_for_each_stat
    @gem_array.each do |gem|
      calculate_overall_score(gem)
    end
  end

  private

  def average_in_float(key)
    sum = 0
    @gem_array.each do |gem|
      sum += gem.stats[key].scan(/\d/).join('').to_f
    end
    sum / @gem_array.size
  end

  def average_stats
    @average_stats ||= {
      used:          average_in_float(:used),
      forks:         average_in_float(:forks),
      stars:         average_in_float(:stars),
      contributors:  average_in_float(:contributors),
      watched:       average_in_float(:watched),
      issues:        average_in_float(:issues)
    }
  end

  def calculate_score_for_each_stat
    @gem_array.each do |gem|
      gem.scores = {
        used:         stat_score(:used, gem),
        forks:        stat_score(:forks, gem),
        stars:        stat_score(:stars, gem),
        contributors: stat_score(:contributors, gem),
        watched:      stat_score(:watched, gem)
      }
    end
  end

  def stat_score(key, gem)
    gem.stats[key].scan(/\d/).join('').to_f / average_stats[key]
  end

  def calculate_overall_score(gem)
    gem.scores.values.each do |value|
      gem.overall_score += value
    end
  end
end

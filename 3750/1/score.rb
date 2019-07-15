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

  # rubocop:disable Metrics/AbcSize
  def calculate_score_for_each_stat
    @gem_array.each do |gem|
      gem.scores = {
        used:         gem.stats[:used].scan(/\d/).join('').to_f / average_stats[:used],
        forks:        gem.stats[:forks].scan(/\d/).join('').to_f / average_stats[:forks],
        stars:        gem.stats[:stars].scan(/\d/).join('').to_f / average_stats[:stars],
        contributors: gem.stats[:contributors].scan(/\d/).join('').to_f / average_stats[:contributors],
        watched:      gem.stats[:watched].scan(/\d/).join('').to_f / average_stats[:watched]
      }
    end
  end
  # rubocop:enable Metrics/AbcSize

  def calculate_overall_score(gem)
    gem.scores.values.each do |value|
      gem.overall_score += value
    end
  end
end

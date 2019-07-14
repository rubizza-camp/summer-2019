require_relative 'gemy'

class Score
  def initialize(gem_array)
    @gem_array = gem_array
  end

  def calculate_overall_score
    calculate_score_for_each_stat
    @gem_array.each do |gem|
      gem.scores.values.each do |one_stat_score_value|
        gem.overall_score += one_stat_score_value
      end
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
        used_score:         gem.stats[:used].scan(/\d/).join('').to_f / average_stats[:used],
        forks_score:        gem.stats[:forks].scan(/\d/).join('').to_f / average_stats[:forks],
        stars_score:        gem.stats[:stars].scan(/\d/).join('').to_f / average_stats[:stars],
        contributors_score: gem.stats[:contributors].scan(/\d/).join('').to_f / average_stats[:contributors],
        watched_score:      gem.stats[:watched].scan(/\d/).join('').to_f / average_stats[:watched]
      }
    end
  end
  # rubocop:enable Metrics/AbcSize
end

class Gemy
  attr_reader :gem_name, :stats, :overall_score, :scores

  def initialize(gem_name)
    @gem_name = gem_name
    @stats = {}
    @scores = {}
    @overall_score = 0
  end

  def scrap_overall_score(average_finder)
    @scores = Score.calculate_score_for_each_stat(average_finder, stats)
    @overall_score = Score.calculate_overall_score(scores)
  end

  def scrap_stats
    @stats = Statistics.new(gem_name).load_stats
  end
end

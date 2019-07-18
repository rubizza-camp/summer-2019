# Class for storing stats about gems
class DataCollector
  attr_reader :stats

  def initialize(stats)
    @stats = stats
  end

  def sort_stats
    stats.sort_by! { |element| element[1] }.reverse!
  end
end

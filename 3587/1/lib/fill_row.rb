class GemSerializer
  attr_reader :name, :stats

  def initialize(name, stats)
    @name = name
    @stats = stats
  end

  def table_row
    [
      @name,
      "used by #{@stats[:used_by]}",
      "watched by #{@stats[:watch]}",
      "#{@stats[:star]} stars",
      "#{@stats[:fork]} forks",
      "#{@stats[:contributors]} contributors",
      "#{@stats[:issues]} issues"
    ]
  end
end

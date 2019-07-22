class RubyGem
  attr_reader :score, :gem_data

  ATTR_WEIGTHS = {
    used_by: 5,
    watched_by: 7,
    stars: 10,
    forks: 3,
    contributors: 6,
    issues: 4
  }.freeze

  def initialize(gem_data)
    @gem_data = gem_data
    @score = score_rating
  end

  def to_s
    [
      @gem_data[:name],
      "used by #{@gem_data[:used_by]}",
      "watched by #{@gem_data[:watched_by]}",
      "#{@gem_data[:stars]} stars",
      "#{@gem_data[:forks]} forks",
      "#{@gem_data[:contributors]} contributors",
      "#{@gem_data[:issues]} issues"
    ].join("\t| ")
  end

  private

  def score_rating
    ATTR_WEIGTHS.each_pair.map do |key, value|
      @gem_data[key] * value
    end.sum
  end
end

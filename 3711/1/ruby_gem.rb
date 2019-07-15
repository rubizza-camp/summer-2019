class RubyGem
  attr_reader :score, :gem_data

  ATTR_WEIGTHS = {
    'used_by' => 10,
    'watched_by' => 10,
    'stars' => 10,
    'forks' => 10,
    'contributors' => 10,
    'issues' => 10
  }.freeze

  def initialize(gem_data)
    @gem_data = gem_data
    @score = score_rating
  end

  def to_s
    [
      @gem_data['name'],
      "used by #{@gem_data['used_by']}",
      "watched by #{@gem_data['watched_by']}",
      "#{@gem_data['stars']} stars",
      "#{@gem_data['forks']} forks",
      "#{@gem_data['contributors']} contributors",
      "#{@gem_data['issues']} issues"
    ].join("\t| ")
  end

  private

  def score_rating
    @score = 0
    ATTR_WEIGTHS.each do |key, value|
      @score += @gem_data[key] * value
    end
    @score
  end
end

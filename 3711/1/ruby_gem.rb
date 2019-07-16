class RubyGem
  attr_reader :score, :gem_data, :name, :used_by, :watched_by, :stars, :forks, :contribs, :issues

  ATTR_WEIGTHS = {
    used_by: 10,
    watched_by: 10,
    stars: 10,
    forks: 10,
    contributors: 10,
    issues: 10
  }.freeze

  def initialize(gem_data)
    @gem_data = gem_data
    @score = score_rating
    fill_attrs
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

  def fill_attrs
    @name = @gem_data[:name]
    @used_by = @gem_data[:used_by]
    @watched_by = @gem_data[:watched_by]
    @stars = @gem_data[:stars]
    @forks = @gem_data[:forks]
    @contribs = @gem_data[:contributors]
    @issues = @gem_data[:issues]
  end

  def score_rating
    ATTR_WEIGTHS.each_pair.map do |key, value|
      @gem_data[key] * value
    end.sum
  end
end

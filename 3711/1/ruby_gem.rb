# :reek:InstanceVariableAssumption
# :reek:TooManyConstants
# :reek:TooManyInstanceVariables
class RubyGem
  attr_reader :name, :source_url, :score
  attr_reader :used_by, :watched_by, :stars, :forks, :contributors, :issues

  WEIGHT_OF_USED_BY       = 10
  WEIGHT_OF_WATCHED_BY    = 10
  WEIGHT_OF_STARS         = 10
  WEIGHT_OF_FORKS         = 10
  WEIGHT_OF_CONTRIBUTORS  = 10
  WEIGHT_OF_ISSUES        = 10

  def initialize(gem_data)
    @gem_date = gem_data
    fill_attr
    @score = score_rating
  end

  private

  def score_rating
    @used_by * WEIGHT_OF_USED_BY +
      @watched_by * WEIGHT_OF_WATCHED_BY +
      @stars * WEIGHT_OF_STARS +
      @forks * WEIGHT_OF_FORKS +
      @contributors * WEIGHT_OF_CONTRIBUTORS +
      @issues * WEIGHT_OF_ISSUES
  end

  # :reek:TooManyStatements
  def fill_attr
    @name         = @gem_date['name']
    @used_by      = @gem_date['used_by']
    @watched_by   = @gem_date['watched_by']
    @stars        = @gem_date['stars']
    @forks        = @gem_date['forks']
    @contributors = @gem_date['contributors']
    @issues       = @gem_date['issues']
    @source_url   = @gem_date['url']
  end
end

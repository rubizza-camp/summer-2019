# :reek:TooManyInstanceVariables
class RubyGemStatistic
  attr_reader :gem_name, :used_by, :watches, :stars, :forks, :contributors, :issues

  def initialize(opts = {})
    @gem_name = opts.fetch(:gem_name)
    @used_by = opts.fetch(:used_by)
    @watches = opts.fetch(:watches)
    @stars = opts.fetch(:stars)
    @forks = opts.fetch(:forks)
    @contributors = opts.fetch(:contributors)
    @issues = opts.fetch(:issues)
  end

  def strings
    [gem_name, "used by #{used_by}", "watched by #{watches}", "#{stars} stars",
     "#{forks} forks", "#{contributors} contributors", "#{issues} issues"]
  end
end

# This class collect all info about gem
# rubocop: disable Metrics/ParameterLists
#:reek:TooManyInstanceVariables:
class MyGem
  attr_reader :gem_name, :watch, :stars, :forks, :issues, :contributors, :used_by, :coolness
  #:reek:LongParameterList:
  def initialize(gem_name, watch, stars, forks, issues, contributors, used_by)
    @gem_name = gem_name
    @watch = watch
    @stars = stars
    @forks = forks
    @issues = issues
    @contributors = contributors
    @used_by = used_by
    @coolness = coolness_calc
  end

  def coolness_calc
    @watch + @stars + @forks + @contributors + @used_by / @issues
  end
end
# rubocop: enable Metrics/ParameterLists

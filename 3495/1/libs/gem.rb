# This class collect all info about gem
# :reek:TooManyInstanceVariables
class MyGem
  attr_reader :gem_name, :watch, :stars, :forks, :issues, :contributors, :used_by, :coolness

  def initialize(gem_name, params)
    @gem_name = gem_name
    @watch = params[:watch]
    @stars = params[:stars]
    @forks = params[:forks]
    @issues = params[:issues]
    @contributors = params[:contributors]
    @used_by = params[:used_by]
    @coolness = coolness_calc
  end

  def coolness_calc
    watch + stars + forks + contributors + used_by / (issues + 1)
  end
end

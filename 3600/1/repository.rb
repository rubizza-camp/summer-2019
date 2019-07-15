# Save gem's data from repos
class Repository
  attr_reader :gem_name, :used_by, :watches, :stars, :forks, :contributors, :issues

  def initialize(opts = {})
    @gem_name = opts[:gem_name]
    @used_by = opts[:used_by]
    @watches = opts[:watches]
    @stars = opts[:stars]
    @forks = opts[:forks]
    @contributors = opts[:contributors]
    @issues = opts[:issues]
  end
end

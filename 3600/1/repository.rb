# Save gem's data from repos
class Repository
  attr_reader :gem_name, :used_by, :watches, :stars, :forks, :contributors, :issues

  def initialize(opts)
    @gem_name = opts[:gem_name]
    @used_by = opts[:used_by]
    @watches = opts[:watches]
    init_stats_and_forks(opts)
  end

  def init_stats_and_forks(opts)
    @stars = opts[:stars]
    @forks = opts[:forks]
    init_contributors_and_issues(opts)
  end

  def init_contributors_and_issues(opts)
    @contributors = opts[:contributors]
  	@issues = opts[:issues]
  end
end

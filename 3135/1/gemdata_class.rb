# The GemData class creates objects with gem data
# :reek:InstanceVariableAssumption, :reek:TooManyInstanceVariables, :reek:TooManyStatements
class GemData
  attr_reader :name, :github_uri,
              :downloads, :watches, :stars, :forks, :issues, :contributors, :used_by

  def initialize(gem_name)
    @name = gem_name
  end

  def populate
    rubygems_stats = RubyGemsStats.call(@name)
    @github_uri = rubygems_stats[:github_uri]
    @downloads = rubygems_stats[:downloads]

    github_stats = GithubStats.call(@github_uri)
    @watches = github_stats[:watches]
    @stars = github_stats[:stars]
    @forks = github_stats[:forks]
    @issues = github_stats[:issues]
    @contributors = github_stats[:contributors]
    @used_by = github_stats[:used_by]
  end
end
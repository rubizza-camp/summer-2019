require_relative 'gem_stat_parser.rb'
require_relative 'github_url.rb'

# class that set all gem info
class GemInfo
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def gem_stat
    github_repo = GithubUrl.new.search_repo(gem_name)
    return unless github_repo
    GemStatParser.new(github_repo).stat_info
  end
end

require_relative 'github_repository_parser.rb'

# Collecting info about gem
class RubyGem
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def used_by
    page = GitHubRepositoryParser.new(name).github_network_dependents
    page.css('a.btn-link').first.text.delete(',').to_i
  end

  def watch
    GitHubRepositoryParser.new(name).github_repository_title.css('a.social-count').first.text.to_i
  end

  def star
    GitHubRepositoryParser.new(name).github_api['watchers']
  end

  def fork
    GitHubRepositoryParser.new(name).github_api['forks']
  end

  def contributors
    GitHubRepositoryParser.new(name).github_repository_title.css('span.num').last.text.to_i
  end

  def issues
    GitHubRepositoryParser.new(name).github_repository_title.css('span.Counter').first.text.to_i
  end
end

require_relative 'github_repository_parser.rb'

# Collecting info about gem
class RubyGem
  attr_reader :name, :parser

  def initialize(name)
    @name = name
    @parser = GitHubRepositoryParser.new(name)
  end

  def used_by
    page = parser.github_network_dependents
    page.css('a.btn-link').first.text.delete(',').to_i
  end

  def watch
    parser.github_repository_title.css('a.social-count').first.text.delete(',').to_i
  end

  def star
    parser.github_general_repository_data['watchers']
  end

  def fork
    parser.github_general_repository_data['forks']
  end

  def contributors
    parser.github_repository_title.css('span.num').last.text.to_i
  end

  def issues
    parser.github_repository_title.css('span.Counter').first.text.to_i
  end
end

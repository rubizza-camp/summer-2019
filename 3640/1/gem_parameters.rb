require 'nokogiri'

class GemParameters
  GEM_PARAMETERS_KEY_VALUE = { star: :stargazers_count,
                               forks: :forks_count,
                               issues: :open_issues_count,
                               watch: :subscribers_count }.freeze

  def self.fetch_gem_parameters(repository, path)
    fetcher = new(repository, path)
    fetcher.fetch_contributors_count
    fetcher.fetch_used_by_count
    fetcher.search_gem_parameters(repository)
    fetcher.gem_parameters
  end

  attr_reader :gem_parameters

  def initialize(repository, path)
    @repository = repository
    @path = path
    @gem_parameters = {}
  end

  def fetch_contributors_count
    contributors_count = contributors.css('span.num.text-emphasized').children[2].text.to_i
    @gem_parameters[:contributors] = contributors_count
  end

  def fetch_used_by_count
    used_by_count = dependents.css('.btn-link')[1].text.delete('^0-9').to_i
    @gem_parameters[:used_by] = used_by_count
  end

  def search_gem_parameters(repository)
    GEM_PARAMETERS_KEY_VALUE.each { |key, value| @gem_parameters[key] = repository[value].to_i }
  end

  private

  def contributors
    Nokogiri::HTML(open("https://github.com/#{@path}"))
  end

  def dependents
    Nokogiri::HTML(open("https://github.com/#{@path}/network/dependents"))
  end
end

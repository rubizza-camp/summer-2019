require 'json'
require 'open-uri'
require 'nokogiri'

GITHUB_REPOSITORIES_API_URL = 'https://api.github.com/search/repositories?q='.freeze
GITHUB_NETWORK_DEPENDENTS = '/network/dependents'.freeze

# Scraping info about gems from github
class GitHubRepositoryParser
  attr_reader :name_gem

  def initialize(name_gem)
    @name_gem = name_gem
  end

  def github_api
    @github_api ||= JSON.parse(URI.open(GITHUB_REPOSITORIES_API_URL + name_gem).read)['items'].first
  end

  def github_repository_title
    @github_repository_title ||= github_parse(github_api['html_url'])
  end

  def github_network_dependents
    github_parse(github_api['html_url'] + GITHUB_NETWORK_DEPENDENTS)
  end

  private

  def github_parse(page)
    Nokogiri::HTML(URI.open(page))
  end
end

require 'mechanize'

class Scraper
  GEM_PARAMETERS_LINKS = { used_by: /REPOSITORY/,
                           watch: /watchers/,
                           star: /stargazers/,
                           forks: /members/,
                           contributors: /contributors/,
                           issues: /issues/ }.freeze

  def self.fetch_gem_parameters(name_gem)
    fetcher = new(name_gem)
    fetcher.fetch_gem_parameters
    fetcher.gem_parameters
  end

  attr_reader :gem_parameters

  def initialize(name_gem)
    @name_gem = name_gem
    @link_search = 'https://github.com/search?q='
    @gem_parameters = {}
  end

  def fetch_gem_parameters
    GEM_PARAMETERS_LINKS.each do |key, value|
      page = (key == :used_by ? used_by_repository : repository)
      tag = page.links_with(href: value)
      @gem_parameters[key] = parameter_value(tag)
    end
  end

  private

  def parameter_value(tag)
    tag.first.to_s.gsub(/[^0-9]/, '').to_i
  end

  def mechanize
    @mechanize ||= Mechanize.new
  end

  def used_by_repository
    mechanize.get(repository.uri.to_s + '/network/dependents')
  end

  def search_page
    mechanize.get(@link_search + @name_gem)
  end

  def link_repository
    @link_repository ||= search_page.links_with(dom_class: 'v-align-middle').first
  end

  def repository
    @repository ||= mechanize.get(link_repository)
  end
end

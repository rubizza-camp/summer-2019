require 'mechanize'

# Class Scraper
class Scraper
  def self.get_gem_parameters(name_gem)
    fetcher = new(name_gem)
    fetcher.get_gem_parameters
    fetcher.gem_parameters
  end

  attr_reader :gem_parameters

  def initialize(name_gem)
    @name_gem = name_gem
    @link_search = 'https://github.com/search?q='
    @gem_parameters_links = { used_by: /REPOSITORY/,
                              watch: /watchers/,
                              star: /stargazers/,
                              forks: /members/,
                              contributors: /contributors/,
                              issues: /issues/ }
    @gem_parameters = {}
  end

  def get_gem_parameters
    @gem_parameters_links.each_key do |key|
      tag = get_page_for_parse(key).links_with(href: @gem_parameters_links[key])
      @gem_parameters[key] = parameter_value(tag)
    end
    @gem_parameters
  end

  private

  def parameter_value(tag)
    tag.first.to_s.gsub(/[^0-9]/, '').to_i
  end

  def mechanize
    @mechanize ||= Mechanize.new
  end

  def get_page_for_parse(parameter)
    return repository if parameter != :used_by
    mechanize.get(repository.uri.to_s + '/network/dependents')
  end

  def search_page
    @mechanize.get(@link_search + @name_gem)
  end

  def link_repository
    @link_repository ||= search_page.links_with(dom_class: 'v-align-middle').first
  end

  def repository
    @repository ||= @mechanize.get(link_repository)
  end
end

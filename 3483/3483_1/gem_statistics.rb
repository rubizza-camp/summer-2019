require 'rubygems'
require 'open-uri'
require 'nokogiri'
#:reek:InstanceVariableAssumption
class GemStatistics
  attr_reader :gem_name, :gem_info

  def initialize(gem_name)
    @gem_name = gem_name
    @gem_info = { gem_name: gem_name }
    fetch_gem
    fetch_used_by
    fetch_watch_star_fork
    fetch_issues
    fetch_contributors
  end

  private

  URL_GEM_SEARCH = 'https://rubygems.org/gems/'.freeze
  BRANCH_OF_GEM_REPOSITORY = '/network/dependents'.freeze

  def fetch_gem
    doc = Nokogiri::HTML(URI.open("#{URL_GEM_SEARCH}""#{gem_name}"))
    @github_url = doc.xpath('//a[@id="code"]/@href')
  end

  def parse_github_page
    @parse_github_page ||= Nokogiri::HTML(URI.open(@github_url.to_s))
  end

  def parse_gem_dependencies
    Nokogiri::HTML(URI.open("#{@github_url}#{BRANCH_OF_GEM_REPOSITORY}"))
  end

  def fetch_used_by
    used_by =
      parse_gem_dependencies.css('a[class *="btn-link selected"]').text.scan(/[0-9,]+/)
    gem_info[:used_by] = used_by[0]
  end

  def fetch_watch_star_fork
    watch_star_fork =
      parse_github_page.css('a[class *="social-count"]').text.scan(/[0-9,]+/)
    gem_info[:watch] = watch_star_fork[0]
    gem_info[:star] = watch_star_fork[1]
    gem_info[:fork] = watch_star_fork[2]
  end

  def fetch_issues
    issues =
      parse_github_page.at_css('span[class *="Counter"]').text.scan(/[0-9,]+/)
    gem_info[:issues] = issues[0]
  end

  def fetch_contributors
    contributors =
      parse_github_page
      .css('span[class *="num text-emphasized"]').text.scan(/[0-9,]+/)
    gem_info[:contributors] = contributors.last
  end
end

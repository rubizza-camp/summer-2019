require 'rubygems'
require 'open-uri'
require 'nokogiri'
#:reek:InstanceVariableAssumption and :reek:Attribute
class GemStatistics
  attr_reader :gem_name, :gem_info
  def initialize(gem_name)
    @gem_name = gem_name
    @gem_info = { 'Gem Name' => gem_name }
  end

  def gem_stats
    fetch_all_gem_params
    gem_info
  end

  private

  URL_GEM_SEARCH = 'https://rubygems.org/gems/'.freeze
  BRANCH_OF_GEM_REPOSITORY = '/network/dependents'.freeze

  def fetch_all_gem_params
    fetch_gem
    fetch_used_by
    fetch_whatch_star_fork
    fetch_issues
    fetch_contributors
  end

  def fetch_gem
    doc = Nokogiri::HTML(URI.open("#{URL_GEM_SEARCH}""#{gem_name}"))
    @patn_to_git = doc.xpath('//a[@id="code"]/@href')
  end

  def open_url_with_all_without_used_by
    Nokogiri::HTML(URI.open(@patn_to_git.to_s))
  end

  def open_url_with_used_by
    Nokogiri::HTML(URI.open("#{@patn_to_git}#{BRANCH_OF_GEM_REPOSITORY}"))
  end

  def fetch_used_by
    used_by =
      open_url_with_used_by.css('a[class *="btn-link selected"]').text.scan(/[0-9,]+/)
    gem_info['Used_by'] = used_by[0]
  end

  def fetch_whatch_star_fork
    star_fork_whatch =
      open_url_with_all_without_used_by.css('a[class *="social-count"]').text.scan(/[0-9,]+/)
    gem_info['Watch'] = star_fork_whatch[0]
    gem_info['Star'] = star_fork_whatch[1]
    gem_info['Fork'] = star_fork_whatch[2]
  end

  def fetch_issues
    issues =
      open_url_with_all_without_used_by.at_css('span[class *="Counter"]').text.scan(/[0-9,]+/)
    gem_info['Issues'] = issues[0]
  end

  def fetch_contributors
    contributors =
      open_url_with_all_without_used_by
      .css('span[class *="num text-emphasized"]').text.scan(/[0-9,]+/)
    gem_info['Contributors'] = contributors.last
  end
end

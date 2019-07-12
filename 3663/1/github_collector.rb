# This class collect all data about gem from Github repository to hash

require 'nokogiri'
require 'open-uri'
require_relative 'github_url_finder.rb'
require_relative 'string_class_expander.rb'

class GitHubCollector
  attr_reader :gems_data, :gem_github_page, :gem_github_page_network

  def initialize(gem_github_url)
    collect_data_from_github(gem_github_url)
  end

  protected

  def collect_data_from_github(gem_github_url)
    @gem_github_page = Nokogiri::HTML(open(gem_github_url))
    @gem_github_page_network = Nokogiri::HTML(open("#{gem_github_url}/network/dependents"))

    @gems_data = {
      gem_used_by: look_for_gem_used_by,
      gem_watched_by: look_for_gem_watched_by,
      gem_stars: look_for_gem_stars,
      gem_forks: look_for_gem_forks,
      gem_contributors: look_for_gem_contributors,
      gem_issues: look_for_gem_issues
    }
  end

  def look_for_gem_used_by
    gem_github_page_network.search('a.btn-link.selected').first.text.squish!.match(/\d+(\,\d+)+/).to_s
  end

  def look_for_gem_watched_by
    gem_github_page.search('a.social-count').first.text.squish!
  end

  def look_for_gem_stars
    gem_github_page.search('a.social-count.js-social-count').text.squish!
  end

  def look_for_gem_forks
    gem_github_page.search('a.social-count').last.text.squish!
  end

  def look_for_gem_contributors
    gem_github_page.search('span.num.text-emphasized').last.text.squish!
  end

  def look_for_gem_issues
    gem_github_page.search('span.Counter').first.text.squish!
  end
end

p gems_data = GitHubCollector.new('https://github.com/rubocop-hq/rubocop/').gems_data

# This class collect all data about gem from Github repository to array of hashes

require 'nokogiri'
require 'open-uri'
require_relative 'score_sorter.rb'

class String
  def squish
    gsub!(/\A[[:space:]]+/, '')
    gsub!(/[[:space:]]+\z/, '')
    gsub!(/[[:space:]]+/, ' ')
    self
  end
end

class GitHubCollector < ScoreSorter
  attr_reader :gems_data_array, :gem_github_page, :github_page_network

  def collect_data_from_github(gems_github_urls_hash)
    create_gems_data_array(gems_github_urls_hash)
    sort_gems_data_array(gems_data_array)
  end

  private

  def create_gems_data_array(gems_github_urls_hash)
    @gems_data_array = gems_github_urls_hash.map do |gem_name, gem_github_url|
      open_github_pages(gem_github_url)
      create_gems_data_hash(gem_name)
    end
  end

  def open_github_pages(gem_github_url)
    @gem_github_page = Nokogiri::HTML(URI.open(gem_github_url))
    @github_page_network = Nokogiri::HTML(URI.open("#{gem_github_url}/network/dependents"))
  end

  def create_gems_data_hash(gem_name)
    { gem_score: convert_stat_to_score([look_for_gem_used_by, look_for_gem_watched_by,
                                        look_for_gem_stars, look_for_gem_forks,
                                        look_for_gem_contributors, look_for_gem_issues]),
      gem_name =>
          {
            gem_used_by: look_for_gem_used_by, gem_watched_by: look_for_gem_watched_by,
            gem_stars: look_for_gem_stars, gem_forks: look_for_gem_forks,
            gem_contributors: look_for_gem_contributors, gem_issues: look_for_gem_issues
          } }
  end

  def look_for_gem_used_by
    github_page_network.search('a.btn-link.selected').first.text.squish.match(/\d+(\,\d+)+/).to_s
  end

  def look_for_gem_watched_by
    gem_github_page.search('a.social-count').first.text.squish
  end

  def look_for_gem_stars
    gem_github_page.search('a.social-count.js-social-count').text.squish
  end

  def look_for_gem_forks
    gem_github_page.search('a.social-count').last.text.squish
  end

  def look_for_gem_contributors
    gem_github_page.search('span.num.text-emphasized').last.text.squish
  end

  def look_for_gem_issues
    gem_github_page.search('span.Counter').first.text.squish
  end
end

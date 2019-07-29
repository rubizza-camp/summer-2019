require 'nokogiri'
require 'open-uri'
require 'xpath'

# class that collect gem info from github page
class GemStatParser
  attr_reader :link

  PATH_TO_USED_BY = '//div[@class="Box-header clearfix"]//a'.freeze
  PATH_TO_WATCH_FORK = '//div//ul/li/a[@class="social-count"]'.freeze
  PATH_TO_STAR = '//div//ul/li/a[@class="social-count js-social-count"]'.freeze
  PATH_TO_ISSUE = '//nav//span[@class="Counter"]'.freeze
  PATH_TO_CONTRIBUTORS = '//div[@class="stats-switcher-wrapper"]/ul/li//span'.freeze

  def initialize(link)
    @link = link
  end

  def stat_info
    info = {
      used_by: parse_used_by,
      watch: parse_watch,
      fork: parse_fork,
      star: parse_star,
      issues: parse_issue,
      contributors: parse_contributor
    }
    stat_with_rating(info)
  end

  private

  def modify_stat(string)
    string.strip.delete(',').to_i
  end

  def github_page
    @github_page ||= begin
      Nokogiri::HTML(URI.open(link))
    rescue OpenURI::HTTPError
      puts 'There is no github repo'
    end
  end

  def github_page_used_by
    link_used_by = link + '/network/dependents'
    @github_page_used_by ||= begin
      Nokogiri::HTML(URI.open(link_used_by))
    rescue OpenURI::HTTPError
      puts 'There is no github repo'
    end
  end

  def parse_used_by
    used_by = github_page_used_by.xpath(PATH_TO_USED_BY)[0].content
    modify_stat(used_by)
  end

  def parse_watch
    watch = github_page.xpath(PATH_TO_WATCH_FORK)[-2].content
    modify_stat(watch)
  end

  def parse_fork
    forks = github_page.xpath(PATH_TO_WATCH_FORK)[-1].content
    modify_stat(forks)
  end

  def parse_star
    star = github_page.xpath(PATH_TO_STAR)[0].content
    modify_stat(star)
  end

  def parse_issue
    issues = github_page.xpath(PATH_TO_ISSUE)[0].content
    modify_stat(issues)
  end

  def parse_contributor
    contributor = github_page.xpath(PATH_TO_CONTRIBUTORS)[3].content
    modify_stat(contributor)
  end

  def stat_with_rating(stat)
    stat.merge!(rating: calculate_rating(stat))
  end

  def calculate_rating(stat)
    stat.values.sum - stat.fetch(:issues)
  end
end

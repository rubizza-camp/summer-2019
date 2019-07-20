require 'webdrivers/geckodriver'
require 'watir'
class RepoScrapper
  attr_reader :repo_info

  def initialize
    @browser = Watir::Browser.new :firefox, headless: true
    @repo_info = {}
  end

  def repo_info_parse
    repo_gem_name
    repo_used_by
    repo_watch_star_forks
    repo_contributors
    repo_issues
  end

  def github_link
    if @browser.link(text: 'Homepage').href.include?('github.com')
      @browser.link(text: 'Homepage').href
    elsif @browser.link(text: 'Source Code').href.include?('github.com')
      @browser.link(text: 'Source Code').href
    else
      raise 'There is no link for github from rubygems.org'
    end
  end

  def get_page(link)
    @browser.goto(link)
    sleep 0.5
  rescue Selenium::WebDriver::Error::UnknownError
    puts 'Check internet connection.'
    exit
  end

  def get_repo_page(link)
    get_page(link)
    get_page(github_link)
    repo_info_parse
    repo_info.each { |key, val| repo_info[key] = val.delete(',').to_i if key != :name }
  end

  def repo_gem_name
    repo_info[:name] = @browser.h1.text.split('/').last
  end

  def repo_used_by
    get_page @browser.url + '/network/dependents'
    repo_info[:used_by] = @browser.link(href: /dependent_type=REPOSITORY/).text.split(' ').first
    get_page @browser.link(text: 'Code').href
  end

  def repo_watch_star_forks
    repo_info[:watchers] = @browser.link(href: /watchers/).text
    repo_info[:stars] = @browser.link(href: /stargazers/).text
    repo_info[:forks] = @browser.link(href: %r{network\/members}).text
  end

  def repo_issues
    repo_info[:issues] = @browser.link(text: /Issues/).text.split(' ').last
  end

  def repo_contributors
    repo_info[:contributors] = @browser.link(href: /contributors/).text.split(' ').first
  end
end

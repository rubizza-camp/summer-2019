require 'webdrivers/geckodriver'
require 'watir'

class RepoScrapper
  attr_reader :repo_info

  def initialize
    @browser = Watir::Browser.new :firefox, headless: true
    @repo_info = {}
  end

  def repo_info_parse
    return 'skip' if repo_gem_name == 'skip'
    return 'skip' if repo_watch_star_forks == 'skip'
    return 'skip' if repo_contributors == 'skip'
    return 'skip' if repo_used_by == 'skip'
    return 'skip' if repo_issues == 'skip'
  end

  def github_link(link)
    return 'flag' if get_page(link) == 'Check internet connection.'

    if @browser.link(text: 'Homepage').href.include?('github.com')
      get_page(@browser.link(text: 'Homepage').href)
    elsif @browser.link(text: 'Source Code').href.include?('github.com')
      get_page(@browser.link(text: 'Source Code').href)
    end
  rescue Selenium::WebDriver::Error::UnknownError, Watir::Exception::UnknownObjectException
    'no_link'
  end

  def get_page(link)
    @browser.goto(link)
    sleep 0.5
  rescue Net::ReadTimeout
    'Check internet connection.'
  end

  def get_repo_page(link)
    return 'flag' if %w[no_link flag].include?(github_link(link)) || repo_info_parse == 'skip'

    repo_info.each { |key, val| repo_info[key] = val.delete(',').to_i if key != :name }
  end

  def repo_gem_name
    repo_info[:name] = @browser.h1.text.split('/').last
  rescue Net::ReadTimeout
    'skip'
  end

  def repo_used_by
    return 'skip' if get_page(@browser.url + '/network/dependents') == 'Check internet connection.'

    repo_info[:used_by] = @browser.link(href: /dependent_type=REPOSITORY/).text.split(' ').first
  rescue Net::ReadTimeout
    'skip'
  end

  def repo_watch_star_forks
    repo_info[:watchers] = @browser.link(href: /watchers/).text
    repo_info[:stars] = @browser.link(href: /stargazers/).text
    repo_info[:forks] = @browser.link(href: %r{network\/members}).text
  rescue Net::ReadTimeout
    'skip'
  end

  def repo_issues
    repo_info[:issues] = @browser.link(text: /Issues/).text.split(' ').last
  rescue Net::ReadTimeout
    'skip'
  end

  def repo_contributors
    repo_info[:contributors] = @browser.link(href: /contributors/).text.split(' ').first
  rescue Net::ReadTimeout
    'skip'
  end
end

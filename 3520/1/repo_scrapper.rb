require 'mechanize'
require 'webdrivers/geckodriver'
require 'watir'
# This class smells of :reek:UtilityFunction and :reek:InstanceVariableAssumption
class RepoScrapper
  attr_reader :repo_info

  def initialize
    @browser = Watir::Browser.new :firefox, headless: true
    @repo_info = {}
  end

  def repo_info_parse
    repo_used_by
    repo_watch
    repo_star
    repo_forks
    repo_issues
    repo_contributors
    p repo_info
  end

  def github_link
    if check_regexp(@browser.link(text: 'Homepage').href)
      @browser.link(text: 'Homepage').href
    elsif check_regexp(@browser.link(text: 'Source Code').href)
      @browser.link(text: 'Source Code').href
    else
      raise 'there is no link for github from rubygems.org'
    end
  end

  def get_repo_page(link)
    @browser.goto(link)
    sleep 2
    @browser.goto(github_link)
  end

  def check_regexp(link)
    link.match?(%r{http[s]*:\/\/[w{3}.]*github.com\/})
  end

  def gem_name
    @browser.h1.text.split('/').last
  end

  def repo_used_by
    @browser.goto(@browser.url + '/network/dependents')
    repo_info[:used_by] = @browser.link(href: /dependent_type=REPOSITORY/).text.split(' ').first
    @browser.goto(@browser.link(text: 'Code').href)
  end

  def repo_watch
    repo_info[:watchers] = @browser.link(href: /watchers/).text.to_i
  end

  def repo_star
    repo_info[:stars] = @browser.link(href: /stargazers/).text
  end

  def repo_forks
    repo_info[:forks] = @browser.link(href: %r{network\/members}).text
  end

  def repo_issues
    repo_info[:issues] = @browser.link(text: /Issues/).text.split(' ').last
  end

  def repo_contributors
    repo_info[:contributors] = @browser.link(href: /contributors/).text.split(' ').first
  end
end

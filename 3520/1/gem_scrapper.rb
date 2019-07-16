require 'mechanize'
require 'webdrivers/geckodriver'
require 'watir'
# This class smells of :reek:UtilityFunction and :reek:InstanceVariableAssumption
class GemScrapper
  def initialize
    @browser = Watir::Browser.new :firefox, headless: true
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

  def get_page(link)
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

  def used_by
    @browser.goto(@browser.url + '/network/dependents')
    used = @browser.link(href: /dependent_type=REPOSITORY/).text.split(' ').first
    @browser.goto(@browser.link(text: 'Code').href)
    used
  end

  def watch
    @browser.link(href: /watchers/).text
  end

  def star
    @browser.link(href: /stargazers/).text
  end

  def fork
    @browser.link(href: %r{network\/members}).text
  end

  def issues
    @browser.link(text: /Issues/).text.split(' ').last
  end

  def contributors
    @browser.link(href: /contributors/).text.split(' ').first
  end

  def repo_info
    p "#{gem_name} |  #{used_by} | #{watch} |" +
      + " #{star} | #{fork} | #{issues} | #{contributors}"
  end
end

require 'nokogiri'
require 'open-uri'
require 'xpath'

# class for parsing info about gem from github page
class Parser
  def initialize
    @arr = {}
  end

  def repository(gname)
    link = search_repo(gname)
    return unless link
    gethash(link)
  end

  private

  def search_repo(gname)
    url = "http://rubygems.org/gems/#{gname}"
    check_page('code', url) || check_page('home', url)
  end

  def check_page(linkid, url)
    link = Nokogiri::HTML(URI.open(url)).css("//a[@id=#{linkid}]").attr('href')
    return unless link
    link.text if link.text.include?('github')
  end

  def git_repo(link)
    github_page = Nokogiri::HTML(URI.open(link))
    github_page
  end

  def git_repo_for_usedby(link)
    link_usedby = link + '/network/dependents'
    github_page_usedby = Nokogiri::HTML(URI.open(link_usedby))
    github_page_usedby
  end

  def modify(str)
    str = str.strip.delete(',').to_i
    str
  end

  def parse_usedby(link)
    github_page_usedby = git_repo_for_usedby(link)
    used_by = github_page_usedby.xpath('//div[@class="Box-header clearfix"]//a')[0].content
    @arr[:used_by] = modify(used_by)
  end

  def parse_watch_fork(link)
    github_page = git_repo(link)
    watch = github_page.xpath('//div//ul/li/a[@class="social-count"]')[-2].content
    @arr[:watch] = modify(watch)
    forks = github_page.xpath('//div//ul/li/a[@class="social-count"]')[-1].content
    @arr[:forks] = modify(forks)
  end

  def parse_star(link)
    github_page = git_repo(link)
    star = github_page.xpath('//div//ul/li/a[@class="social-count js-social-count"]')[0].content
    @arr[:star] = modify(star)
  end

  def parse_issue(link)
    github_page = git_repo(link)
    issues = github_page.xpath('//nav//span[@class="Counter"]')[0].content
    @arr[:issues] = modify(issues)
  end

  def parse_contributor(link)
    git_page = git_repo(link)
    contributors = git_page.xpath('//div[@class="stats-switcher-wrapper"]/ul/li//span')[3].content
    @arr[:contributors] = modify(contributors)
  end

  def total
    sum = 0
    @arr.each { |_, value| sum += value }
    sum -= @arr.fetch(:issues)
    @arr[:sum] = sum
  end

  def gethash(link)
    parse_usedby(link)
    get_watch_fork_star_issue_contrib(link)
    total
    @arr
  end

  def get_watch_fork_star_issue_contrib(link)
    parse_watch_fork(link)
    parse_star(link)
    parse_issue(link)
    parse_contributor(link)
  end
end

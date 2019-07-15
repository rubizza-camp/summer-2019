require 'xpath'
require 'nokogiri'
require 'open-uri'

module ModifyData
  def modify(str)
    str = str.strip.delete(',').to_i
    str
  end
end

# class for parsing info about gem from github page
class Parser
  def initialize
    @arr = {}
  end

  include ModifyData

  def search_repo(gname)
    page = Nokogiri::HTML(URI.open("http://rubygems.org/gems/#{gname}"))
    homepage = page.xpath('//a[@id="home"]').attr('href')
    sourcepage = page.xpath('//a[@id="code"]').attr('href')
    check_page(sourcepage, homepage, gname)
  end

  def check_page(sourcepage, homepage, gname)
    if !sourcepage.nil?
      sourcepage.value if sourcepage.value.include?('github')
    elsif homepage.value.include?('github')
      homepage.value
    else
      puts "There is no github repo for #{gname} gem"
    end
  end

  def git_repo(link)
    @github_page = Nokogiri::HTML(URI.open(link))
    @github_page
  end

  def git_repo_for_usedby(link)
    link_usedby = link + '/network/dependents'
    @github_page_usedby = Nokogiri::HTML(URI.open(link_usedby))
    @github_page_usedby
  end

  def parse_usedby
    used_by = @github_page_usedby.xpath('//div[@class="Box-header clearfix"]//a')[0].content
    @arr[:used_by] = modify(used_by)
  end
    file = file['gems']

  def parse_watch_fork
    watch = @github_page.xpath('//div//ul/li/a[@class="social-count"]')[-2].content
    @arr[:watch] = modify(watch)
    forks = @github_page.xpath('//div//ul/li/a[@class="social-count"]')[-1].content
    @arr[:forks] = modify(forks)
  end

  def parse_star
    star = @github_page.xpath('//div//ul/li/a[@class="social-count js-social-count"]')[0].content
    @arr[:star] = modify(star)
  end

  def parse_issue
    issues = @github_page.xpath('//nav//span[@class="Counter"]')[0].content
    @arr[:issues] = modify(issues)
  end

  def parse_contributor
    contributors = @github_page.xpath('//div[@class="stats-switcher-wrapper"]/ul/li//span')[3].content
    @arr[:contributors] = modify(contributors)
  end

  def total
    total = 0
    @arr.each { |_, value| total += value }
    total -= @arr.fetch(:issues)
    @arr[:total] = total
  end

  def gethash
    parse_usedby
    parse_watch_fork
    parse_star
    parse_issue
    parse_contributor
    total
    @arr
  end

  def repository(gname)
    link = search_repo(gname)
    return if link.nil?
    git_repo(link)
    git_repo_for_usedby(link)
    gethash
  end
end

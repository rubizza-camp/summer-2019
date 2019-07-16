# page = mechanize.get('https://rubygems.org/gems/') # + 'gemname from file'
require 'mechanize'
require 'watir'
# This class smells of :reek:UtilityFunction and :reek:InstanceVariableAssumption
class GemScrapper
  def initialize
    @mechanize = Mechanize.new
    @mechanize.user_agent_alias= 'Mac Safari 4'
    # @next_page = self.double_check(self.github_link)
  end

  def watir_patch(link)
    browser = Watir::Browser.new
    browser.goto(link)
    sleep 2
    contrib_s = browser.link(href: /contributors/).text.split(' ').first
    browser.close
    contrib_s
  end

  def get_page(link)
    # link = 'https://rubygems.org/gems/addressable'
    @page = @mechanize.get(link)
    get_github_link
  end

  def get_github_link
    @next_page = self.github_link
  end

  def github_link
    if @page.link_with(text: 'Homepage').href.match?(/http[s]*:\/\/[w{3}.]*github.com\//)
      @page.link_with(text: 'Homepage').click
    elsif @page.link_with(id: 'code').href.match?(/http[s]*:\/\/[\w.]*[w{3}.]*github.com/)
      @page.link_with(id: 'code').click
    else
      raise 'there is no link for github from rubygems.org'
    end
  end

  def gem_name
    @next_page.search('h1 strong').text
  end

  def used_by
    @next_page.link_with(href: /pulse/).click
        .link_with(href: %r{network\/dependencies}).click
        .link_with(text: /Dependent/).click
        .link_with(text: /Repositories/).text.split(' ').first
  end


  def watch
    @next_page.link_with(href: /watchers/).text.split(' ').first
  end

  def star
    @next_page.search('a.social-count.js-social-count').first.text.split(' ').last
  end

  def fork
    @next_page.link_with(href: %r{network\/members}).text.split(' ').first
  end

  def issues
    @next_page.link_with(text: /Issues/).text.split(' ').last
  end

  def contributors
    if @next_page.link_with(text: /contributors/).text.split(' ').first == 'Fetching'
      watir_patch(@next_page.uri.to_s)
    else
      @next_page.link_with(text: /contributors/).text.split(' ').first
    end
  end

  def repo_info
    p "#{gem_name} |  #{used_by} | #{watch} | #{star} | #{fork} | #{issues} | #{contributors}"
  end
end

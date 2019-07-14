# page = mechanize.get('https://rubygems.org/gems/') # + 'gemname from file'
require 'mechanize'
# This class smells of :reek:UtilityFunction
class GemScrapper
  def initialize(link)
    @mechanize = Mechanize.new
    @page = @mechanize.get(link)
    @link = self.github_link
  end

  def github_link
    if @page.link_with(id: 'code').nil?
      if @page.link_with(text: 'Homepage').href.match?(/http[s]*:\/\/[w{3}.]*github.com\//)
        @page.link_with(text: 'Homepage').click
      else
        raise 'smth wrong with finding github link'
      end
    else
      if @page.link_with(id: 'code').href.match?(/http[s]*:\/\/[w{3}.]*github.com\//)
        @page.link_with(id: 'code').click
      else
        raise 'there is now link for github from rubygems.org'
      end
    end
  end

  def gem_name(page = @page)
    page.search('h1.t-display.page__heading').text.split(/\s*\W+[-]*[\d|\W]+/).select { |el| el.size > 1 }[0]
  end

  def used_by(link = @link)
    link.link_with(href: /pulse/).click
        .link_with(href: %r{network\/dependencies}).click
        .link_with(text: /Dependent/).click
        .link_with(text: /Repositories/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
    # d_cies = pulse.link_with(href: %r{network\/dependencies}).click
    # d_dents = d_cies.link_with(text: /Dependent/).click
    # d_dents.link_with(text: /Repositories/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
  end

  def watch(link = @link)
    link.link_with(href: /watchers/).text.split(/\s/).last
  end

  def star(link = @link)
    link.search('a.social-count.js-social-count').first.text.split(/\s/).last
  end

  def fork(link = @link)
    link.link_with(href: %r{network\/members}).text.split(/\s/).last
  end

  def contributors(link = @link)
    link.link_with(text: /contributors/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
  end

  def issues(link = @link)
    link.link_with(text: /Issues/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
  end
end

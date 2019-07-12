# page = mechanize.get('https://rubygems.org/gems/') # + 'gemname from file'
require 'mechanize'
# This class smells of :reek:UtilityFunction
class GemScrapper
  def initialize(link)
    @mechanize = Mechanize.new
    @page = @mechanize.get(link)
    @link = @page.link_with(id: 'code').click
  end

  def used_by(link)
    link.link_with(href: /pulse/).click
        .link_with(href: %r{network\/dependencies}).click
        .link_with(text: /Dependent/).click
        .link_with(text: /Repositories/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
    # d_cies = pulse.link_with(href: %r{network\/dependencies}).click
    # d_dents = d_cies.link_with(text: /Dependent/).click
    # d_dents.link_with(text: /Repositories/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
  end

  def watch(link)
    link.link_with(href: /watchers/).text.split(/\s/).last
  end

  def star(link)
    link.search('a.social-count.js-social-count').first.text.split(/\s/).last
  end

  def fork(link)
    link.link_with(href: %r{network\/members}).text.split(/\s/).last
  end

  def contributors(link)
    link.link_with(text: /contributors/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
  end

  def issues(link)
    link.link_with(text: /Issues/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
  end
end

require './config'
class Scraper
  include Config
  FOR_USED_BY = '/network/dependents'.freeze
  URL = 'https://rubygems.org/gems/'.freeze

  attr_reader :row

  def normalize
    @link = @link.split('/').take(5).join('/')
  end

  def flatten_and_to_natural
    @row.flatten.map { |attr| attr.delete(',').to_i }
  end

  def initialize(link)
    @link = link
    normalize
    @row = []
    @page = Nokogiri::HTML(URI.open(@link))
    three_in_one_push
    @link << FOR_USED_BY
    @page = Nokogiri::HTML(URI.open(@link))
    @row << used_by
    @row = flatten_and_to_natural
  end

  def three_in_one_push
    @row << watches_stars_forks << contributors << issues
  end

  def watches_stars_forks
    @page.css('.social-count').to_a.map { |item| item.text.strip }
  end

  def used_by
    @page.to_s[/(\d*,?\d+)\s*\n*\s*(Repositories)/]
    Regexp.last_match(1)
  end

  def contributors
    @page.css('.num.text-emphasized').to_a[-1].text.strip
  end

  def issues
    @page.css('.Counter').to_a.first.text
  end

  def popularity
    Config::WEIGHTS.zip(@row).inject(0) { |sum, (weight, value)| sum + (weight * value) }
  end
end

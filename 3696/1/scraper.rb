# frozen_string_literal: true

require './config'
class Scraper
  include Config
  FOR_USED_BY = '/network/dependents'
  URL = 'https://rubygems.org/gems/'
  USED_BY_COUNT_GRAB_REGEXP = /(\d*,?\d+)\s*\n*\s*(Repositories)/.freeze
  attr_reader :row

  def initialize(link)
    @link = normalize(link)
    @github_page ||= Nokogiri::HTML(URI.open(@link))
  end

  def scrape
    flatten_and_to_natural(Array.new(watches_stars_forks << contributors << issues << used_by))
  end

  private

  def normalize(link)
    link.split('/').take(5).join('/')
  end

  def flatten_and_to_natural(arr)
    arr.flatten.map { |attr| attr.delete(',').to_i }
  end

  def watches_stars_forks
    @github_page.css('.social-count').map { |item| item.text.strip }
  end

  def used_by
    page = Nokogiri::HTML(URI.open(@link + FOR_USED_BY))
    page.to_s.match(USED_BY_COUNT_GRAB_REGEXP).captures.first.strip
  end

  def contributors
    @github_page.css('.num.text-emphasized').to_a.last.text.strip
  end

  def issues
    @github_page.css('.Counter').first.text
  end
end

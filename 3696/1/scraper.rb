# frozen_string_literal: true

require 'watir'
require 'webdrivers'
class Scraper
  FOR_USED_BY = '/network/dependents'
  URL = 'https://rubygems.org/gems/'
  USED_BY_COUNT_GRAB_REGEXP = /(\d*,?\d*,?\d+)\s*\n*\s*(Repositories)/
  attr_reader :row

  def initialize(link)
    @link = normalize(link)
  end

  def scrape
    flatten_and_to_natural(Array.new(watches_stars_forks << contributors << issues << used_by))
  end

  def close
    browser.close
  end

  private

  def browser
    @browser ||= generate_browser
  end

  def generate_browser
    browser = Watir::Browser.new :chrome, headless: true
    browser.goto @link
    sleep 1
    browser
  end

  attr_reader :link

  def normalize(link)
    link.split('/').take(5).join('/')
  end

  def flatten_and_to_natural(arr)
    arr.flatten.map { |attr| attr.delete(',').to_i }
  end

  def watches_stars_forks
    browser.elements(css: '.social-count').to_a.map { |number| number.text.strip }
  end

  def contributors
    browser.elements(css: '.num.text-emphasized').last.text.strip
  end

  def used_by
    used_by_browser = browser
    used_by_browser.goto(link + FOR_USED_BY)
    used_by_browser.html.match(USED_BY_COUNT_GRAB_REGEXP).captures.first.strip
  end

  def issues
    browser.element(css: '.Counter').text
  end
end

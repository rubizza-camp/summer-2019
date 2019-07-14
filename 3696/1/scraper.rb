# frozen_string_literal: true

class Scraper
  FOR_USED_BY = '/network/dependents'
  URL = 'https://rubygems.org/gems/'
  USED_BY_COUNT_GRAB_REGEXP = /(\d*,?\d*,?\d+)\s*\n*\s*(Repositories)/.freeze

  def initialize(link, browser)
    @link = normalize(link)
    @browser_page = generate_browser_page(browser)
  end

  def scrape
    to_natural(watches_stars_forks.merge(contributors, issues, used_by))
  end

  private

  attr_reader :link, :browser_page

  def generate_browser_page(browser)
    browser.goto(link)
    sleep 0.1 until browser.elements(css: '.num.text-emphasized').size == 4
    browser
  end

  def normalize(link)
    link.split('/').take(5).join('/')
  end

  def to_natural(attributes)
    attributes.transform_values { |attr| attr.delete(',').to_i }
  end

  def watches_stars_forks
    keys = %i[watches stars forks]
    enumerator = browser_page.elements(css: '.social-count')
                             .to_a.map { |number| number.text.strip }.each
    keys.each_with_object({}) do |key, hash|
      hash[key] = enumerator.next
    end
  end

  def contributors
    { contributors: browser_page.elements(css: '.num.text-emphasized').last.text.strip }
  end

  def used_by
    used_by_browser = browser_page
    used_by_browser.goto(link + FOR_USED_BY)
    { used_by: used_by_browser.html.match(USED_BY_COUNT_GRAB_REGEXP).captures.first.strip }
  end

  def issues
    { issues: browser_page.element(css: '.Counter').text }
  end
end

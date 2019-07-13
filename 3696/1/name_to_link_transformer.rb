require 'watir'
require 'webdrivers'
class NameToLinkTransformer
  def initialize(name)
    @name = name
  end

  def link
    github_in_code_link || github_in_home_link || 'no-link'
  end

  private

  def browser
    @browser ||= generate_browser
  end

  def generate_browser
    browser = Watir::Browser.new :chrome, headless: true
    browser.goto "https://rubygems.org/gems/#{@name}"
    browser
  end

  def github_in_code_link
    browser.element(css: 'a#code').attribute_value('href') if browser.element(css: 'a#code').exists?
  end

  def github_in_home_link
    alternative = browser.element(css: 'a#home').attribute_value('href')
    return alternative if alternative.include?('github')
  end
end

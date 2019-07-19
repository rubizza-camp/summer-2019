# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require 'optparse'
require 'pry'
require_relative 'yamlreader'
require_relative 'linker'
# This is GemRepoParser class. This class get all information you need from GitHub pages
class GemRepoParser
  SELECTOR = "a[class='btn-link selected']"
  CSS_SELECTOR = {
    gem_name: { css_path: '.public', index: 0 },
    contributors: { css_path: '.text-emphasized', index: 3 },
    issues: { css_path: "span[class='Counter']", index: 0 },
    stars: { css_path: '.social-count', index: 2 },
    watch: { css_path: '.social-count', index: 0 },
    forks: { css_path: '.social-count', index: 1 }
  }.freeze

  def initialize(links)
    @links = links
  end

  def result_strings
    @links.map do |link|
      doc = Nokogiri::HTML(URI.open(link))
      used_by_link = Nokogiri::HTML(URI.open("#{link}/network/dependents"))

      info(doc) + used_by(used_by_link)
    end
  end

  private
  # :reek:FeatureEnvy
  def info(doc)
    param_value = {}
    CSS_SELECTOR.each_pair do |param, selector|
      param_value[param] = doc.css(selector[:css_path])[selector  [:index]].text.strip
    end
    strings(param_value)
  end

  def strings(param_value)
    [param_value[:gem_name], param_value[:contributors] + ' contributors',
     param_value[:issues] + ' issues', param_value[:stars] + ' stars',
     ' watched by ' + param_value[:watch], param_value[:forks] + ' forks '].join('  ')
  end

  def used_by(used_by_link)
    'used by ' + used_by_link.css(SELECTOR)[0].text.delete('Repositories').strip
  end
end

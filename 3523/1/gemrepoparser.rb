# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require 'optparse'
require_relative 'yamlreader'
require_relative 'linker'
SELECTOR = "a[class='btn-link selected']"
# This is GemRepoParser class. This class get all information you need from GitHub pages
class GemRepoParser
  def initialize(links)
    @links = links
  end

  def info
    @links.map do |link|
      doc = Nokogiri::HTML(URI.open(link))
      used_by_link = Nokogiri::HTML(URI.open("#{link}/network/dependents"))
      [gem_name(doc), used_by(used_by_link), watch(doc), stars(doc), forks(doc),
       contributors(doc), issues(doc)].join('  ')
    end
  end

  private

  def gem_name(doc)
    doc.css('.public')[0].text.strip
  end

  def used_by(used_by_link)
    'used by ' + used_by_link.css(SELECTOR)[0].text.delete('Repositories').strip
  end

  def watch(doc)
    'watched by ' + doc.css('.social-count')[0].text.strip
  end

  def stars(doc)
    doc.css('.social-count')[1].text.strip + ' stars'
  end

  def forks(doc)
    doc.css('.social-count')[2].text.strip + ' forks'
  end

  def contributors(doc)
    doc.css('.text-emphasized')[3].text.strip + ' contibutors'
  end

  def issues(doc)
    doc.css("span[class='Counter']")[0].text + ' issues'
  end
end

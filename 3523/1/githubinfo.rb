# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require 'optparse'
require_relative 'filereader'
require_relative 'linker'
# This is GitHubInfo class. This class get all information from GitHub pages
class GitHubInfo
  def initialize(links)
    @links = links
  end

  def info
    @links.map do |link|
      doc = Nokogiri::HTML(URI.open(link))
      used_by_link = Nokogiri::HTML(URI.open("#{link}/network/dependents"))
      "#{gem_name(doc)}  #{used_by(used_by_link)}  #{watch(doc)} " \
                       " #{stars(doc)}  #{forks(doc)}  #{contributors(doc)}  #{issues(doc)}"
    end
  end

  private

  def gem_name(doc)
    doc.css('.public')[0].text.strip
  end

  def used_by(used_by_link)
    selector = "a[class='btn-link selected']"
    'used by ' + used_by_link.css(selector)[0].text.delete('Repositories').strip
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
    selector = doc.css('.reponav-item')[1].text
    res = selector.strip.delete('Issues') if selector.include?('Issues')
    res.strip + ' issues'
  end
end

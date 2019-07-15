# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require 'terminal-table'
require_relative 'reader'

# :reek:UtilityFunction
# :reek:TooManyStatements
# class GitHubInfo
class GitHubInfo
  attr_reader :git_hub_info
  def initialize(links)
    @links = links
    @git_hub_info = []
  end

  def info
    @links.each do |url|
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
      used_by_link = Nokogiri::HTML(URI.open("#{url}/network/dependents"))
      @git_hub_info << "#{gem_name(doc)}
      #{used_by(used_by_link)}
      #{watch(doc)} #{stars(doc)}
      #{forks(doc)}
      #{contributors(doc)}
      #{issues(doc)}"
    end
    @git_hub_info
  end

  private

  def gem_name(doc)
    doc.css("a[data-pjax='#js-repo-pjax-container']")[0].text.strip
  end

  def used_by(used_by_link)
    selector = "a[class='btn-link selected']"
    used_by_link.css(selector)[0].text.delete('Repositories').strip
  end

  def watch(doc)
    doc.css('.social-count')[0].text.strip
  end

  def stars(doc)
    doc.css('.social-count')[1].text.strip
  end

  def forks(doc)
    doc.css('.social-count')[2].text.strip
  end

  def contributors(doc)
    doc.css('.text-emphasized')[3].text.strip
  end

  def issues(doc)
    selector = doc.css('.reponav-item')[1].text
    res = selector.strip.delete('Issues') if selector.include?('Issues')
    res.strip
  end
end

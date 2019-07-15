# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'json'
require 'terminal-table'
require_relative 'gets_link'

# :reek:UtilityFunction
# class GitValue
class GitValue
  attr_reader :git_value

  def initialize(links)
    @links = links
    @git_value = []
  end

  def gets_value
    @links.each do |git_link|
      parse = Nokogiri::HTML(URI.open(git_link))
      used_by_parse = Nokogiri::HTML(URI.open("#{git_link}/network/dependents"))
      @git_value << "#{name(parse)}
      #{used_by(used_by_parse)}
      #{watched_by(parse)}
      #{stars(parse)}
      #{forks(parse)}
      #{contributors(parse)}
      #{issues(parse)}"
    end
    @git_value
  end

  private

  def name(parse)
    parse.css("a[data-pjax='#js-repo-pjax-container']")[0].text.strip
  end

  def used_by(used_by_parse)
    used_by_parse.css(
      "a[class='btn-link selected']"
    )[0].text.delete('Repositories').strip
  end

  def watched_by(parse)
    parse.css('.social-count')[0].text.strip
  end

  def stars(parse)
    parse.css('.social-count')[1].text.strip
  end

  def forks(parse)
    parse.css('.social-count')[2].text.strip
  end

  def contributors(parse)
    parse.css('.text-emphasized')[3].text.strip
  end

  def issues(parse)
    parse.css("span[class='Counter']")[0].text
  end
end

# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'json'
require 'terminal-table'
require_relative 'link'

# This class gets all the info from the gem githab page.
class GitValue
  attr_reader :git_value
  # git value this is an array of strings to which we enter values.
  def initialize(links)
    @links = links
    @git_value = []
  end

  def reception_value
    @links.each do |git_link|
      parse = Nokogiri::HTML(URI.open(git_link))
      used_by_parse = Nokogiri::HTML(URI.open("#{git_link}/network/dependents"))
      @git_value << "#{gem_name(parse)}
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

  def gem_name(parse)
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

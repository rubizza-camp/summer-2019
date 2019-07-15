require 'rest-client'
require 'nokogiri'
require 'open-uri'
require 'terminal-table'

class GemInfo
  attr_reader :score

  def initialize(name, github_url)
    @name = name
    @github_url = github_url
  end

  def parse
    parse_github
    watched_by
    stars
    forks
    contributors
    issues
    used_by
    calculate_score
  end

  def output
    [@name, @used_by, @watched_by, @stars, @forks, @contributors, @issues]
  end

  private

  def parse_github
    @parse_github ||= Nokogiri::HTML(::Kernel.open(@github_url))
  end

  def parse_github_dependents
    Nokogiri.HTML(::Kernel.open("#{@github_url}/network/dependents"))
  end

  def watched_by
    @watched_by = parse_github.css("a[class='social-count']")[0].text.tr('^0-9', '')
  end

  def stars
    @stars = parse_github.css("a[class='social-count js-social-count']").text.tr('^0-9', '')
  end

  def forks
    @forks = parse_github.css("a[class='social-count']")[1].text.tr('^0-9', '')
  end

  def contributors
    @contributors = parse_github.css("span[class='num text-emphasized']").last.text.tr('^0-9', '')
  end

  def issues
    @issues = parse_github.css("span[class='Counter']")[0].text.tr('^0-9', '')
  end

  def used_by
    @used_by = parse_github_dependents.css('.btn-link').css('.selected').text.tr('^0-9', '')
  end

  def calculate_score
    @score = @used_by.to_i / 5 + @watched_by.to_i / 2 + @stars.to_i +
             @forks.to_i + 10 * @contributors.to_i + @issues.to_i
  end
end

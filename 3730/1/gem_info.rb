require 'rest-client'
require 'nokogiri'
require 'open-uri'
require 'terminal-table'

# :reek:TooManyInstanceVariables
class GemInfo
  attr_reader :score

  def initialize(name, github_url)
    @name = name
    @github_url = github_url
    @used_by = used_by
    @watched_by = watched_by
    @stars = stars
    @forks = forks
    @contributors = contributors
    @issues = issues
  end

  def calculate_score
    @score = @used_by.to_i / 5 + @watched_by.to_i / 2 + @stars.to_i +
             @forks.to_i + 10 * @contributors.to_i + @issues.to_i
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
    parse_github.css("a[class='social-count']")[0].text.tr('^0-9', '')
  end

  def stars
    parse_github.css("a[class='social-count js-social-count']").text.tr('^0-9', '')
  end

  def forks
    parse_github.css("a[class='social-count']")[1].text.tr('^0-9', '')
  end

  def contributors
    parse_github.css("span[class='num text-emphasized']").last.text.tr('^0-9', '')
  end

  def issues
    parse_github.css("span[class='Counter']")[0].text.tr('^0-9', '')
  end

  def used_by
    parse_github_dependents.css('.btn-link').css('.selected').text.tr('^0-9', '')
  end
end

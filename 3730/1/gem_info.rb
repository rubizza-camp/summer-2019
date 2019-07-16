require 'nokogiri'
require 'open-uri'

class GemInfo
  attr_reader :score, :gem_info

  def initialize(name, github_url)
    @github_url = github_url
    @gem_info = { name: name, used_by: used_by, watched_by: watched_by,
                  stars: stars, forks: forks, contributors: contributors, issues: issues }
  end

  def calculate_score
    @score = 0
    gem_info.each_value { |value| @score += value.to_i }
  end

  def output
    gem_info.values
  end

  private

  def path
    {
      watch: '//a[@class="social-count"]',
      star: '//a[@class="social-count js-social-count"]',
      fork: '//a[@class="social-count"]',
      contributor: '//a/span[@class="num text-emphasized"]',
      issue: '//a/span[@class="Counter"]',
      used_by: '//a[@class="btn-link selected"]'
    }
  end

  def parse_github
    @parse_github ||= Nokogiri::HTML(::Kernel.open(@github_url))
  end

  def parse_github_dependents
    Nokogiri.HTML(::Kernel.open("#{@github_url}/network/dependents"))
  end

  def parse_element(path, index)
    parse_github.css(path)[index].text.tr('^0-9', '')
  end

  def watched_by
    parse_element(path[:watch], 0)
  end

  def stars
    parse_element(path[:star], 0)
  end

  def forks
    parse_element(path[:fork], -1)
  end

  def contributors
    parse_element(path[:contributor], -1)
  end

  def issues
    parse_element(path[:issue], 0)
  end

  def used_by
    parse_github_dependents.css(path[:used_by]).text.tr('^0-9', '')
  end
end

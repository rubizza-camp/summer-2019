require 'nokogiri'
require './gems_stats'
require 'open-uri'
require 'json'

# :reek:InstanceVariableAssumption
class Parser
  attr_reader :gem_name

  def initialize(gem_name:)
    @gem_name = gem_name
  end

  def repo_url
    return @repo_url if @repo_url
    json_str = open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
    @repo_url = JSON(json_str)['source_code_uri']
  end

  def repo_dependents_url
    repo_url + '/network/dependents'
  end

  def repo_doc
    @repo_doc ||= Nokogiri::HTML(::Kernel.open(repo_url).read)
  end

  def repo_dependents_doc
    @repo_dependents_doc ||= Nokogiri::HTML(::Kernel.open(repo_dependents_url).read)
  end

  def xpaths
    {
      used_by: '//a[@class="btn-link selected"]',
      watches: '//a[@class="social-count"]',
      stars: '//a[@class="social-count js-social-count"]',
      forks: '//a[@class="social-count"]',
      contributors: '//a/span[@class="num text-emphasized"]',
      issues: '//a/span[@class="Counter"]'
    }
  end

  def repo_nodes_by_xpath(key)
    repo_doc.xpath(xpaths[key])
  end

  def parse_used_by
    repo_dependents_doc.xpath(xpaths[:used_by]).text.gsub(/\D/, '').to_i
  end

  def parse_watch
    repo_nodes_by_xpath(:watches).text.strip.delete(' ').gsub(/\D/, '').to_i
  end

  def parse_stars
    repo_nodes_by_xpath(:stars).text.gsub(/\D/, '').gsub(/\D/, '').to_i
  end

  def parse_forks
    repo_nodes_by_xpath(:forks).last.text.gsub(/\D/, '').gsub(/\D/, '').to_i
  end

  def parse_contributors
    repo_nodes_by_xpath(:contributors).last.text.strip.delete(' ').gsub(/\D/, '').to_i
  end

  def parse_issues
    repo_nodes_by_xpath(:issues).first.text.strip.delete(' ').gsub(/\D/, '').to_i
  end

  def create_statistic
    Stats.new(
      gem_name: gem_name,
      used_by: parse_used_by,
      watches: parse_watch,
      stars: parse_stars,
      forks: parse_forks,
      contributors: parse_contributors,
      issues: parse_issues
    )
  end
end

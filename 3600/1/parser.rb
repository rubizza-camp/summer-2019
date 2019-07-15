require 'nokogiri'
require_relative 'repository'
require 'open-uri'
require 'json'

# Data acquisition
class Parser
  attr_reader :gem_name

  def initialize(gem_name:)
    @gem_name = gem_name
  end

  JSON_URL = 'https://rubygems.org/api/v1/gems/'.freeze

  def url
    json_str = ::Kernel.open(JSON_URL + "#{gem_name}.json").read
    @url ||= JSON(json_str)['source_code_uri']
  end

  def dependents_url
    url + '/network/dependents'
  end

  def doc
    @doc ||= Nokogiri::HTML(::Kernel.open(url).read)
  end

  def dependents_doc
    @dependents_doc ||= Nokogiri::HTML(::Kernel.open(dependents_url).read)
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

  def nodes_by_xpath(key)
    doc.xpath(xpaths[key])
  end

  def used_by
    dependents_doc.xpath(xpaths[:used_by]).text.gsub(/\D/, '').to_i
  end

  def watch
    nodes_by_xpath(:watches).text.strip.delete(' ').gsub(/\D/, '').to_i
  end

  def stars
    nodes_by_xpath(:stars).text.gsub(/\D/, '').gsub(/\D/, '').to_i
  end

  def forks
    nodes_by_xpath(:forks).last.text.gsub(/\D/, '').gsub(/\D/, '').to_i
  end

  def contributors
    nodes_by_xpath(:contributors).last.text.strip.delete(' ').gsub(/\D/, '').to_i
  end

  def issues
    nodes_by_xpath(:issues).first.text.strip.delete(' ').gsub(/\D/, '').to_i
  end

  def create_statistic
    Repository.new(
      gem_name: gem_name,
      used_by: used_by,
      watches: watch,
      stars: stars,
      forks: forks,
      contributors: contributors,
      issues: issues
    )
  end
end


require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'JSON'

# The GemData class creates objects with gem data
# :reek:InstanceVariableAssumption, :reek:TooManyInstanceVariables, :reek:TooManyStatements
class GemData
  attr_reader :name, :github_uri,
              :downloads, :watches, :stars, :forks, :issues, :contributors, :used_by

  def initialize(gem_name)
    @name = gem_name
  end

  def populate
    rubygems_stats = RubyGemsStats.call(@name)
    @github_uri = rubygems_stats[:github_uri]
    @downloads = rubygems_stats[:downloads]

    github_stats = GithubStats.call(@github_uri)
    @watches = github_stats[:watches]
    @stars = github_stats[:stars]
    @forks = github_stats[:forks]
    @issues = github_stats[:issues]
    @contributors = github_stats[:contributors]
    @used_by = github_stats[:used_by]
  end
end

# RubyGemsStats fetches data from rubygems.org by api
class RubyGemsStats
  def self.call(gem_name)
    new(gem_name).call
  end

  def call
    @data = call_rubygems_api
    github_link.merge(downloads_stat)
  end

  private

  def initialize(name)
    @name = name
  end

  def call_rubygems_api
    uri = "https://rubygems.org/api/v1/gems/#{@name}.json"
    JSON.parse(Net::HTTP.get(URI(uri)))
  end

  def downloads_stat
    { downloads: @data['downloads'] }
  end

  def github_link
    { github_uri: [@data['source_code_uri'], @data['homepage_uri']]
      .find { |link| link.to_s.include? 'github.com' } }
  end
end

# GithubStats class fetches data from github page by html parsing
class GithubStats
  def self.call(github_uri)
    new(github_uri).call
  end

  def call
    stats.merge(used_by).transform_values { |value| value.text.gsub(/\D/, '').to_i }
  end

  private

  def initialize(uri)
    @uri = uri
  end

  # rubocop:disable Security/Open
  def fetch_html(uri)
    Nokogiri::HTML(open(uri))
  end
  # rubocop:enable Security/Open

  # :reek:FeatureEnvy:
  def stats
    doc = fetch_html(@uri)
    tag = doc.css('.social-count')
    {
      watches: tag[0],
      stars: tag[1],
      forks: tag[2],
      issues: doc.css('.Counter')[0],
      contributors: doc.css("span[class='num text-emphasized']")[3]
    }
  end

  def used_by
    doc = fetch_html(@uri << '/network/dependents')
    { used_by: doc.css("a[class='btn-link selected']") }
  end
end

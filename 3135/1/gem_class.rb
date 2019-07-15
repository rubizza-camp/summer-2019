require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'JSON'
# The GemData class
# :reek:InstanceVariableAssumption, :reek:TooManyInstanceVariables, :reek:TooManyStatements
class GemData
  attr_reader :name, :rating, :watches, :stars, :forks, :issues, :contributors, :used_by, :github_link

  def initialize(name)
    @name = name
  end

  def populate(link)
    #response = call_rubygems_api(@name)
    #@rating = fetch_rating_stat(response)
    #@github_link = fetch_github_link(response)
    puts GithubStats.call(link)
    ##puts [@watches, @stars, @forks, @issues, @contributors, @used_by]
    #github_parse(@github_link)
  end
end

class RubyGemsStats

  def self.call(gem_name)
    new(gem_name).call
  end

  # def call
  # end

  def initialize(name)
    @name = name
  end

  #def call_rubygems_api(name)
  #  uri = "https://rubygems.org/api/v1/gems/#{name}.json"
  #  JSON.parse(Net::HTTP.get(URI(uri)))
  #end

  #def fetch_rating_stat(data)
  #  data['downloads']
  #end

  #def fetch_github_link(data)
  #  [data['source_code_uri'], data['homepage_uri']].find { |link| link.to_s.include? 'github.com' }
  #end
end

class GithubStats

  def self.call(github_uri)
    new(github_uri).call
  end

  def call
    stats.merge(used_by).transform_values{ |value| value.text.gsub(/\D/, '').to_i }
  end

  private

  def initialize(uri)
    @uri = uri
  end

  def fetch_html(uri)
    Nokogiri::HTML(open(uri))
  end

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
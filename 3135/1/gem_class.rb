require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'JSON'
# The GemData class
# :reek:InstanceVariableAssumption, :reek:TooManyInstanceVariables, :reek:TooManyStatements
class GemData
  attr_reader :name, :rating, :watch, :star, :fork, :issues, :contributors, :used_by, :github_link

  def self.call(name)
    new(name).call
  end

  private

  def call(name)
    response = call_rubygems_api # these should be private and be called within the class(?)
    @rating = rating_stat(response)
    @github_link = fetch_github_link(response)
    github_stats = GithubStats.call(github_link)
    @used_by = github_stats.used_by
    github_parse(@github_link)    
  end

  def initialize(name)
    @name = name
  end

  def call_rubygems_api
    uri = "https://rubygems.org/api/v1/gems/#{@name}.json"
    JSON.parse(Net::HTTP.get(URI(uri)))
  end

  def rating_stat(data)
    data['downloads']
  end

  def fetch_github_link(data)
    [data['source_code_uri'], data['homepage_uri']].find { |link| link.to_s.include? 'github.com' }
  end

  # rubocop:disable Metrics/AbcSize, Security/Open
  # :reek:DuplicateMethodCall
  def github_parse(link)
    github_stats(link)
    github_used_by(link)
  end
  # rubocop:enable Metrics/AbcSize, Security/Open
  def github_stats(link)
    doc = Nokogiri::HTML(open(link))
    tag = doc.css('.social-count')
    watch, star, forks, _ = tag.map { |el| el.text.gsub(/\D/, '').to_i }

    issues = doc.css('.Counter')[0].text.gsub(/\D/, '')
    contributors = doc.css("span[class='num text-emphasized']")[3].text.gsub(/\D/, '')
    [watch, star, forks, issues,contributors]
  end

  def github_used_by(link)
    doc = Nokogiri::HTML(open("#{link}/network/dependents"))
    doc.css("a[class='btn-link selected']").text.gsub(/\D/, '')
  end

end

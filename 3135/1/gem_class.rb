require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'JSON'
# The GemData class
# :reek:InstanceVariableAssumption, :reek:TooManyInstanceVariables, :reek:TooManyStatements
class GemData
  attr_reader :name, :rating, :watch, :star, :fork, :issues, :contributors, :used_by

  def initialize(name)
    @name = name
  end

  def call_rubygems_api
    uri = "https://rubygems.org/api/v1/gems/#{@name}.json"
    @response = JSON.parse(Net::HTTP.get(URI(uri)))
  end

  def rating_stat
    @rating = @response['downloads']
  end

  def github_link
    @github = [@response['source_code_uri'], @response['homepage_uri']]
              .find { |link| link.to_s.include? 'github.com' }
  end

  # rubocop:disable Metrics/AbcSize, Security/Open
  # :reek:DuplicateMethodCall
  def github_parse
    doc = Nokogiri::HTML(open(@github))
    @watch = doc.css('.social-count')[0].text.gsub(/\D/, '')
    @star = doc.css('.social-count')[1].text.gsub(/\D/, '')
    @fork = doc.css('.social-count')[2].text.gsub(/\D/, '')
    @issues = doc.css('.Counter')[0].text.gsub(/\D/, '')
    @contributors = doc.css("span[class='num text-emphasized']")[3].text.gsub(/\D/, '')

    doc = Nokogiri::HTML(open("#{@github}/network/dependents"))
    @used_by = doc.css("a[class='btn-link selected']").text.gsub(/\D/, '')
  end
  # rubocop:enable Metrics/AbcSize, Security/Open
end

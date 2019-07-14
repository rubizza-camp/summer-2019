require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'JSON'
require 'YAML'

class Gems
  attr_reader :name, :github, :stats, :rating, :response

  def initialize(name)
    @name = name
    @response = call_rubygems_api
    @github = github_link
    @rating = downloads_stat
    @stats = github_parse
  end

  private
  # returns parsed rubygem.org json response as a hash
  def call_rubygems_api
    uri = "https://rubygems.org/api/v1/gems/#{@name}.json"
    JSON.parse(Net::HTTP.get(URI(uri)))
  end
    
  # returns downloads stat from rubygems.org as a string
  def downloads_stat
    @response['downloads']
  end
    
  # returns github link as a string
  def github_link
    [@response['source_code_uri'], @response['homepage_uri']]
    .find { |link| link.to_s.include? 'github.com' }
  end
    
  # returns parsed github page stats as a hash
  def github_parse
    stat_data = {}
    
    doc = Nokogiri::HTML(open(@github))
    stat_data[:watch] = doc.css('.social-count')[0]
    stat_data[:star] = doc.css('.social-count')[1]
    stat_data[:fork] = doc.css('.social-count')[2]
    stat_data[:issues] = doc.css('.Counter')[0]
    stat_data[:contributors] = doc.css("span[class='num text-emphasized']")[3]
    
    doc = Nokogiri::HTML(open("#{@github}/network/dependents"))
    stat_data[:used_by] = doc.css("a[class='btn-link selected']")
    
    stat_data.transform_values! { |value| value.text.gsub(/\D/, '') }
  end
end
require 'open-uri'
require 'nokogiri'
require 'net/http'
require 'JSON'

class GemData
  attr_reader :name, :stats, :rating

  def initialize(name)
    @name = name
  end

  # returns parsed rubygem.org json response as a hash
  def call_rubygems_api
    uri = "https://rubygems.org/api/v1/gems/#{@name}.json"
    @response = JSON.parse(Net::HTTP.get(URI(uri)))
  end

  # returns downloads stat from rubygems.org as a string
  def rating_stat
    @rating = @response['downloads']
  end

  # returns github link as a string
  def github_link
    @github = [@response['source_code_uri'], @response['homepage_uri']]
              .find { |link| link.to_s.include? 'github.com' }
  end

  # returns parsed github page stats as a hash
  def github_parse
    @stats = {} # Hash.new('not-parsed!')

    doc = Nokogiri::HTML(open(@github))
    @stats[:watch] = doc.css('.social-count')[0]
    @stats[:star] = doc.css('.social-count')[1]
    @stats[:fork] = doc.css('.social-count')[2]
    @stats[:issues] = doc.css('.Counter')[0]
    @stats[:contributors] = doc.css("span[class='num text-emphasized']")[3]

    doc = Nokogiri::HTML(open("#{@github}/network/dependents"))
    @stats[:used_by] = doc.css("a[class='btn-link selected']")

    @stats.transform_values! { |value| value.text.gsub(/\D/, '') }
  end
end

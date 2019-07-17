require 'json'
require 'open-uri'
require 'httparty'

class GemsApiHandler
  attr_reader :gem_github
  attr_reader :gem_name

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def find_github_link
    url_check
  end

  private

  def call_api_gem
    HTTParty.get("https://rubygems.org/api/v1/gems/#{@gem_name}.json")
  end

  def url_check
    if call_api_gem['source_code_uri'] || call_api_gem['homepage_uri']
      @gem_github = call_api_gem['source_code_uri'] || call_api_gem['homepage_uri']
    else
      puts "ERROR: There is no github links on gem, named #{@gem_name}. Sorry, bro"
    end
  end
end

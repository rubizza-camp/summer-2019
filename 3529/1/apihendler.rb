require 'json'
require 'open-uri'
require 'httparty'

class GemsApiHendler
  attr_reader :gem_github

  def initialize(gem_name)
    @gem_name = gem_name
    @url = HTTParty.get("https://rubygems.org/api/v1/gems/#{@gem_name}.json")
  end

  def find_github
    url_check
  end

  def url_check
    if @url['source_code_uri'] && @url['homepage_uri']
      @gem_github = if @url['source_code_uri']
                      @url['source_code_uri']
                    else
                      @url['homepage_uri']
                    end
    else
      puts "ERROR: There is no github links on gem, named #{@gem_name}. Sorry, bro"
    end
  end
end

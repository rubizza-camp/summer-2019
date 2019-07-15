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
    begin
      url_check
    rescue JSON::ParserError => exc
      puts "ERROR: There is no gem, named #{@gem_name}. Sorry, bro"
      puts exc
    end
  end

  def url_check
    if @url['source_code_uri'].nil?
      if @url['homepage_uri'].nil?
        puts "ERROR: There is no github links on gem, named #{@gem_name}. Sorry, bro"
      else
        @gem_github = @url['homepage_uri']
      end
    else
      @gem_github = @url['source_code_uri']
    end
  end
end

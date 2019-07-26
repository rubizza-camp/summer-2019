require 'nokogiri'
require './yaml_parser'
require 'open-uri'
require 'json'

class LinkBuilder
  def initialize(gem_name)
    @ruby_gems_api_link = "https://rubygems.org/api/v1/gems/#{gem_name}"
  end

  def build_github_link
    buffer = URI.open(@ruby_gems_api_link).read
    JSON.parse(buffer)['source_code_uri']
  end
end

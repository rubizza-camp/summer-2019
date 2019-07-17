require 'httparty'
require 'json'

class GithubPage
  include HTTParty
  attr_accessor :contrib_page, :page
  base_uri 'https://rubygems.org/api/v1/gems'

  def initialize(gem_name)
    @name = gem_name
    begin
      rubygems_page = HTTParty.get("https://rubygems.org/api/v1/gems/#{gem_name}")
    rescue SocketError
      puts 'check your internet connection'
      exit
    end
    parsed = JSON.parse(rubygems_page.body)
    @github_link = parsed['source_code_uri'] || parsed['homepage_uri']
  end

  def fetch
    page = HTTParty.get("#{@github_link}/network/dependents").to_s
    File.write("#{@name}.html", page)
    contrib_page = HTTParty.get(@github_link).to_s
    File.write("#{@name}_contrib.html", contrib_page)
    { criterias: page, contrib: contrib_page }
  end
end

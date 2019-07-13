require 'httparty'
require 'json'

class GitPage
  include HTTParty
  attr_accessor :contrib_page, :page
  base_uri 'https://rubygems.org/api/v1/gems'

  def initialize(gem_name)
    @name = gem_name
    begin
      gems_page = HTTParty.get("https://rubygems.org/api/v1/gems/#{gem_name}")
    rescue SocketError
      exit
    end
    parsed = JSON.parse(gems_page.body)
    @github_link = parsed['source_code_uri'] || parsed['homepage_uri']
  end

  def feth
    page = HTTParty.get("#{@github_link}/network/dependents").to_s
    File.write("#{@name}.html", page)
    contrib_page = HTTParty.get(@github_link).to_s
    File.write("#{@name}_contrib.html", contrib_page)
    { criterias: page, contrib: contrib_page }
  end
end

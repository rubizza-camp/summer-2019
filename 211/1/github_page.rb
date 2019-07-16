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

  def write_files
    file = File.open("#{@name}.html", 'w')
    page = HTTParty.get("#{@github_link}/network/dependents")
    file.puts page.to_s
    file.close
    file_main = File.open("#{@name}_contrib.html", 'w')
    contrib_page = HTTParty.get(@github_link.to_s)
    file_main.puts contrib_page.to_s
    file_main.close
  end
end

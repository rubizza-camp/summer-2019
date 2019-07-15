require 'httparty'
require 'json'

class GithubPage
  include HTTParty
  attr_accessor :main_page, :page
  base_uri 'https://rubygems.org/api/v1/gems'
  def initialize(gem_name)
    @name = gem_name
    rubygems_page = HTTParty.get("https://rubygems.org/api/v1/gems/#{gem_name}")
    parsed = JSON.parse(rubygems_page.body)
    @github_link = parsed['source_code_uri'] || parsed['home_page_uri']
  end

  def write_files
    file = File.open("#{@name}.html", 'w')
    page = HTTParty.get("#{@github_link}/network/dependents")
    file.puts page.to_s
    file.close
    file_main = File.open("#{@name}_main.html", 'w')
    main_page = HTTParty.get(@github_link.to_s)
    file_main.puts main_page.to_s
    file_main.close
  end
end

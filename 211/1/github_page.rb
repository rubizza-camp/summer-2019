require 'httparty'  
require 'json'

class GithubPage
  include HTTParty
  attr_accessor  :main_page, :page
    base_uri 'https://rubygems.org/api/v1/gems'
  def initialize(gem_name)
    name = gem_name
    rubygems_page = HTTParty.get("https://rubygems.org/api/v1/gems/#{gem_name}")
    github_link = JSON.parse(rubygems_page.body)['source_code_uri'] || JSON.parse(rubygems_page.body)['home_page_uri']
    file = File.open("#{gem_name}.html", "w")
    page = HTTParty.get("#{github_link}/network/dependents")
    file.puts page.to_s
    file.close
    file_main = File.open("#{gem_name}_main.html", "w")
    main_page = HTTParty.get("#{github_link}")
    file_main.puts main_page.to_s
    file_main.close

  end
end

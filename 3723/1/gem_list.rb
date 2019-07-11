require 'rubygems'
require 'terminal-table'
require 'json'
require 'yaml'
require 'faraday'
require 'nokogiri'
require 'open-uri'

list = YAML.load_file('ruby_gems.yml')

def take_repo(list)
  list.dig('gems').map do |info|
    gem_presense = Faraday.get "https://rubygems.org/api/v1/gems/#{info}.json"
    valid_gem = gem_presense.body.include?('name')
    if valid_gem
      response = Faraday.get "https://api.github.com/search/repositories?q=#{info}"
      data = JSON.parse(response.body)
      repo = data['items'][0]['full_name']
      "https://api.github.com/repos/#{repo}"
    end
  end
end

def gem_stats(list)
  rows = []
  take_repo(list).compact.map do |repo|
    response  = Faraday.get "#{repo}"
    data = JSON.parse(response.body)
    name = data['name']
    watch = "watched by #{data['watchers_count']}"
    stars = "#{data['stargazers_count']} stars"
    forks = "forks #{data['forks_count']}"
    issues = "issues #{data['open_issues_count']}"
    rows << [name, watch, stars, forks, issues]
  end
  table = Terminal::Table.new :rows => rows
  puts table
end

gem_stats(list)

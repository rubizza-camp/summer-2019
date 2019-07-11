require 'rubygems'
require 'terminal-table'
require 'json'
require 'yaml'
require 'faraday'
require 'nokogiri'
require 'open-uri'

list = YAML.load_file('ruby_gems.yml')

def gem_presence(html)
  #page = Nokogiri::HTML.parse(open(html))  
  #page.css('body').text.include?('gem install')
end

def take_repo(list)
  list.dig('gems').map do |info|
    response = Faraday.get "https://api.github.com/search/repositories?q=#{info}"
    data = JSON.parse(response.body)
    repo = data['items'][0]['full_name']
    for_presence = "https://raw.githubusercontent.com/#{repo}/master/README.md"
    "https://api.github.com/repos/#{repo}"
  end
end

def gem_stats(list)
  rows = []
  take_repo(list).map do |repo|
    response  = Faraday.get "#{repo}"
    data = JSON.parse(response.body)
    rows << [data['name'], "watched by #{data['watchers_count']}", "#{data['stargazers_count']} stars", "forks #{data['forks_count']}", "issues #{data['open_issues_count']}"]
  end
  table = Terminal::Table.new :rows => rows
  puts table
end

gem_stats(list)

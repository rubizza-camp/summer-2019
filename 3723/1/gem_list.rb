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

def contributors_count(list)
  doc = Nokogiri::HTML.parse(open(list))
  doc.css('#js-repo-pjax-container > div.container.new-discussion-timeline.experiment-repo-nav > div.repository-content > div.overall-summary.overall-summary-bottomless > div > div > ul > li:nth-child(4) > a > span').text.strip
end

def used_by_count(list)
  doc = Nokogiri::HTML.parse(open(list))
  doc.css('.btn-link').css('.selected').text.split(/[^\d]/).join
end

def gem_stats(list)
  rows = []
  take_repo(list).compact.map do |repo|
    response  = Faraday.get "#{repo}"
    html_for_parse = repo.sub('/api.github.com/repos/', '/github.com/')
    data = JSON.parse(response.body)
    contributors = "#{contributors_count(html_for_parse)} contributors"
    used_by = "used by #{used_by_count(html_for_parse)}"
    name = data['name']
    watch = "watched by #{data['watchers_count']}"
    stars = "#{data['stargazers_count']} stars"
    forks = "forks #{data['forks_count']}"
    issues = "issues #{data['open_issues_count']}"
    rows << [name, used_by, watch, stars, forks, contributors, sissues]
  end
  table = Terminal::Table.new :rows => rows
  puts table
end

puts used_by_count('https://github.com/tj/terminal-table/network/dependents')
#gem_stats(list)

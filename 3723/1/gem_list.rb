require 'json'
require 'yaml'
require 'faraday'

list = YAML.load_file('ruby_gems.yml')

def take_repo(list)
  list.dig('gems').map do |info|
    response = Faraday.get "https://rubygems.org/api/v1/gems/#{info}.json"
    data = JSON.parse(response.body)
    data['source_code_uri'].sub!('http:', 'https:')
    data['source_code_uri'].sub!('/github.com/', '/api.github.com/repos/')
  end
end

def gem_stats(list)
  take_repo(list).map do |repo|
    response  = Faraday.get "#{repo}"
    data = JSON.parse(response.body)
  end
end

puts take_repo(list)
puts gem_stats(list)

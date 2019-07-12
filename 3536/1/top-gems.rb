require 'yaml'
require 'net/http'
require 'uri'
require 'json'


def gems_stat
  names = YAML::load(open('top-gems.yml'))['gems']
  result = []
  names.each do |gem|
    url = 'https://api.github.com/search/repositories?q=' + gem.to_s
    uri = URI.parse(url)

    gem_content = Net::HTTP.get(uri)
    key_data = JSON.parse(gem_content)

    repo_url = key_data['items'][0]['url']
    star = key_data['items'][0]['stargazers_count']
    fork = key_data['items'][0]['forks_count']
    issues = key_data['items'][0]['open_issues_count']

    result.push([star, fork, issues])

  end
    p result
end

gems_stat

require 'YAML'
require 'Gems'
require 'octokit'
require 'uri'

class TopGems
  gem_list = YAML.load_file('gems.yml')['gems']

  client = Octokit::Client.new(access_token: '8ab9b46acee5e6c2eae941db1dd39b5d4767ef24')
  client.user.login

  result = {}
  gem_list.each do |gem|
    gem_link = Gems.info(gem)['source_code_uri'].gsub('https://github.com/', '')
    repo = client.repo gem_link
    info = {
      name: repo[:name],
      stargazers: repo[:stargazers_count],
      forks_count: repo[:forks_count],
      issues: repo[:open_issues_count],
      subscribers: repo[:subscribers_count]
    }

    result[gem] = info
  end
  puts result
end

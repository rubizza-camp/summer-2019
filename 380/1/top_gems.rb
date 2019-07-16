require 'YAML'
require 'Gems'
require 'octokit'
require 'uri'

class TopGems
  def run
    list = gem_list('gems.yml')

    client = Octokit::Client.new(access_token: 'dafc3260d5cb09fb99dd60fe872f7134cf194daa')
    client.user.login

    result = {}
    list.each do |gem|
      gem_link = Gems.info(gem)['source_code_uri'].gsub('https://github.com/', '')
      puts gem_link
      repo = client.repo gem_link
      puts repo
      info = {
        name: repo[:name],
        stargazers: repo[:stargazers_count],
        forks_count: repo[:forks_count],
        issues: repo[:open_issues_count],
        subscribers: repo[:subscribers_count]
      }
      puts info
      result[gem] = info
    end
    puts result
  end

  def gem_list(file)
    YAML.load_file(file)['gems']
  end
end

TopGems.new.run

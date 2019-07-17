require 'YAML'
require 'Gems'
require 'octokit'
require 'uri'
require 'pry'

class TopGems
  def run
    gem_list = parse_file('gems.yml')
    result = {}
    gem_list.each do |gem|
      repo_id = parse_answer_of_gems(gem)
      github_info = github_info(repo_id) if repo_id
      result[gem] = parse_from(github_info) if github_info
    end
    puts result
  end

  def parse_from(gem_info)
    {
      name: gem_info[:name],
      stargazers: gem_info[:stargazers_count],
      forks_count: gem_info[:forks_count],
      issues: gem_info[:open_issues_count],
      subscribers: gem_info[:subscribers_count]
    }
  end

  def parse_answer_of_gems(gem)
    result = Gems.info(gem)['source_code_uri'].gsub('https://github.com/', '')
    if result
      result
    else
      puts "No information about <#{gem}> on rubygems."
      return nil
    end
  end

  def github_info(gem_link)
    client.repo gem_link
  rescue Octokit::InvalidRepository
    raise 'Invalid as a repository identifier.'
  end

  def parse_file(file)
    YAML.load_file(file)['gems']
  rescue Errno::ENOENT
    raise 'No file "gems.yml" in such derictory!'
  end

  def client(access_token = 'b52dd1e5572b8797d4d94e57b3094bcd4a574235')
    Octokit::Client.new(access_token: access_token)
  rescue Octokit::Unauthorized
    puts 'Enter Valid access_token'
  end
end

TopGems.new.run

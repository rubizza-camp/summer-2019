require 'YAML'
require 'Gems'
require 'octokit'
require 'uri'
require 'pry'
require 'terminal-table'
require 'optparse'
require 'nokogiri'

class TopGems
  def run
    gem_list = parse_file('gems.yml')
    result = {}
    gem_list.each do |gem|
      repo_id = parse_answer_of_gems(gem)
      api_info = github_api_info(repo_id) if repo_id
      page_info = github_page_info(repo_id) if repo_id
      result[gem] = parse_from(api_info, page_info) if api_info && page_info
    end
    puts print result
  end

  private

  def parse_from(api_info, page_info)
    {
      name: api_info[:name],
      stargazers: api_info[:stargazers_count],
      forks_count: api_info[:forks_count],
      issues: api_info[:open_issues_count],
      subscribers: api_info[:subscribers_count],
      contributors: page_info[:contributors],
      used_by: page_info[:used_by]
    }
  end

  def github_page_info(uri)
    url = 'https://github.com/' + uri[:user] + '/' + uri[:repo]
    cons = Nokogiri::HTML(open(url)).css('span.num.text-emphasized').children[2].text.to_i
    url += '/network/dependents'
    used_by = Nokogiri::HTML(open(url)).css('.btn-link')[1].text.delete('^0-9').to_i
    {
      contributors: cons,
      used_by: used_by
    }
  end

  def github_api_info(gem_link)
    client.repo gem_link
  rescue Octokit::InvalidRepository
    raise 'Invalid as a repository identifier.'
  end

  def popularity(info)
    info.values.select { |value| value.is_a?(Numeric) }.reduce(:+)
  end

  def parse_answer_of_gems(gem)
    info = Gems.info(gem)
    if info
      url = info['source_code_uri'] || info['homepage_uri'] # .sub!(%r{http.*com/}, '')
      url.sub!(/https\:\/\/github.com\//, '') if url.include? 'https://github.com/'
      url.sub!(/http\:\/\/github.com\//, '')  if url.include? 'http://github.com/'
      puts url
      url = url.split('/')
      {
        user: url[0],
        repo: url[1]
      }
    else
      puts "No information about <#{gem}> on rubygems."
      return nil
    end
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

  def print(result)
    Terminal::Table.new do |table|
      table.headings = [
        'Gem', 'Used By', 'Watched By', 'Stars', 'Forks', 'Contributors', 'Issues'
      ]
      result.keys.each do |gem|
        table << result_parse(result, gem)
      end
    end
  end

  def result_parse(result, gem)
    result[gem].values_at(
      :name,
      :used_by,
      :subscribers,
      :stargazers,
      :forks_count,
      :contributors,
      :issues
    )
  end
end

TopGems.new.run

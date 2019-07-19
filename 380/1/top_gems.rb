require 'YAML'
require 'optparse'
require 'terminal-table'
require 'pry'
require_relative 'parse'

class TopGems
  include Parse

  def run
    opts = parse_options
    gem_list = parse_file
    result = {}
    gem_list.each do |gem|
      repo_id = parse_uri_of(gem)
      api_info = parse_api_info(repo_id) if repo_id
      page_info = parse_page_info(repo_id) if repo_id
      result[gem] = parse_from(api_info, page_info) if api_info && page_info
    end
    puts print(result, opts[:count])
  end

  private

  def popularity(info)
    info.values.select { |value| value.is_a?(Numeric) }.reduce(:+)
  end

  def client(access_token = 'b52dd1e5572b8797d4d94e57b3094bcd4a574235')
    Octokit::Client.new(access_token: access_token)
  rescue Octokit::Unauthorized
    puts 'Enter Valid access_token'
  end

  def print(result, count)
    Terminal::Table.new do |table|
      table.headings = [
        'Gem', 'Used By', 'Watched By', 'Stars', 'Forks', 'Contributors', 'Issues'
      ]
      # result.sort_by { |_key, gem_info| sum_parameters_from(gem_info) }
      result.keys.each do |gem|
        table << result_parse(result, gem)
      end
    end
  end

  def sum_parameters_from(gem_info)
    puts gem_info.values_at(
      :used_by,
      :subscribers,
      :stargazers,
      :forks_count,
      :contributors,
      :issues
    ).inject(0) { |a, e| a + e }
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

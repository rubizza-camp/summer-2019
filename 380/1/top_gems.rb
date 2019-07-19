require 'YAML'
require 'optparse'
require 'terminal-table'
require 'pry'
require_relative 'parse'

class TopGems
  include Parse

  def run
    opts = parse_options
    gem_list = parse_file(opts[:file], opts[:name])
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

  def print(gem_hash, count)
    Terminal::Table.new do |table|
      table.headings = [
        'Gem', 'Used By', 'Watched By', 'Stars', 'Forks', 'Contributors', 'Issues'
      ]
      sorted = sort_result(gem_hash, count)
      sorted.each do |gem|
        table << result_parse(gem)
      end
    end
  end

  def sort_result(result, count = nil)
    result_array = result.sort_by { |_key, gem_info| gem_info[:popularity] }
    result_array.reverse!
    result_array = result_array[0, count] if count && count.is_a?(Integer) && count > 0 && count < result.size
    result_array
  end

  def result_parse(gem)
    gem[1].values_at(
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

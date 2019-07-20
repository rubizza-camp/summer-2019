require 'YAML'
require 'optparse'
require 'terminal-table'
require 'pry'
require_relative 'parse'

class TopGems
  include Parse

  def run
    selected = parse_options
    gem_list = parse_file_with(selected[:file], selected[:name])
    result = {}
    client = check_token
    gem_list.each do |gem|
      gem_hash = rubygems_response(gem)
      info = gem_info(gem_hash, client) unless gem_hash.nil?
      result[gem] = parse_from(info) unless info.nil?
    end
    puts table_of(result, selected[:count])
  end

  private

  def popularity(info)
    info.values.select { |value| value.is_a?(Numeric) }.reduce(:+)
  end

  def check_token
    puts 'Enter Github API Access Token'
    token = gets.chomp.to_s
    Octokit::Client.new(access_token: token)
  rescue Octokit::Unauthorized
    puts 'Wrong Access Token, '
    client(token)
  end

  def table_of(gem_hash, count)
    Terminal::Table.new do |table|
      table.headings = [
        'Gem', 'Used By', 'Watched By', 'Stars', 'Forks', 'Contributors', 'Issues'
      ]
      sorted = sort_result(gem_hash, count)
      sorted.each do |gem|
        table << result(gem)
      end
    end
  end

  def sort_result(result, count = nil)
    result_array = result.sort_by { |_key, gem_info| gem_info[:popularity] }
    result_array.reverse!
    result_array = result_array.first(count) if count
    result_array
  end

  def parse_from(info)
    api_info = info[:api]
    page_info = info[:page]
    {
      name: api_info[:name],
      stargazers: api_info[:stargazers_count],
      forks_count: api_info[:forks_count],
      issues: api_info[:open_issues_count],
      subscribers: api_info[:subscribers_count],
      contributors: page_info[:contributors],
      used_by: page_info[:used_by],
      popularity: [api_info[:stargazers_count],
                   api_info[:open_issues_count],
                   api_info[:subscribers_count],
                   page_info[:contributors],
                   page_info[:used_by]].inject(:+)
    }
  end

  def result(gem)
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

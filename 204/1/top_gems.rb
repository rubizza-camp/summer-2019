require 'gems'
require 'yaml'
require 'octokit'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'terminal-table'
require 'optparse'
require_relative 'filters.rb'
require_relative 'parser.rb'

class GemsTop
  include Filters
  include Parser
  # :reek:TooManyStatements
  def run
    options = parse_options
    client = build_client(access_token)
    data = load_yaml(options[:file])
    data = filter_by_name(data, options[:name_sort])
    result = info(data, client)
    result = filter_by_top(result, options[:top])
    result = sort_by_popularity(result)
    puts output(result)
  end

  private

  # :reek:UtilityFunction
  # :reek:NilCheck:
  # :reek:TooManyStatements
  # :reek:NestedIterators:
  # :reek:FeatureEnvy
  # :reek:UtilityFunction
  def build_client(access_token)
    begin
      client = Octokit::Client.new(access_token: access_token)
      client.user.login
    rescue Octokit::Unauthorized
      raise 'Please enter valid Personal Auth Token'
    end
    client
  end

  def access_token
    puts 'Enter your Github Personal Access Token'
    gets.chomp
  end

  # :reek:UtilityFunction

  def load_yaml(file)
    raise 'File not exists' unless File.exist?(file)

    YAML.load_file(file)
  end

  def info(data, client)
    data.map { |gem| [gem.to_sym, gem_info(gem, client)] }
  end

  # rubocop: disable Lint/UselessSetterCall
  # :reek:TooManyStatements
  def gem_info(gem, client)
    gem_data = {}
    description = Gems.info(gem)
    uri = (
      description['source_code_uri'] || description['homepage_uri']).sub!(%r{http.*com/}, '')
    repo = repository(uri, client)
    contributors_count = contributors(uri)
    used_by_count = dependents(uri)
    gem_data[gem.to_sym] = gem_properties(repo, contributors_count, used_by_count)
  end
  # rubocop: enable Lint/UselessSetterCall

  def repository(uri, client)
    repo = client.repo uri
    repo
  rescue Octokit::InvalidRepository
    raise gem.to_s + ' didnt have github repo'
  end

  # :reek:FeatureEnvy
  def gem_properties(repo, contributors_count, used_by_count)
    info = {
      name: repo[:name], stargazers: repo[:stargazers_count],
      forks_count: repo[:forks_count], issues: repo[:open_issues_count],
      subscribers: repo[:subscribers_count], contributors: contributors_count,
      used_by: used_by_count
    }
    info[:popularity] = popularity(info)
    info
  end

  # :reek:UtilityFunction
  def popularity(info)
    info.values.select { |value| value.is_a?(Numeric) }.reduce(:+)
  end

  def contributors(uri)
    Nokogiri::HTML(open('https://github.com/' + uri, 'User-Agent' => 'Noo'))
    contributors(uri).css('span.num.text-emphasized').children[2].text.to_i
  end

  def dependents(uri)
    Nokogiri::HTML(open('https://github.com/' + uri + '/network/dependents', 'User-Agent' => 'Noo'))
    dependents(uri).css('.btn-link')[1].text.delete('^0-9').to_i
  end

  # :reek:UtilityFunction
  def result_parse(result, gem)
    result[gem].values_at(
      :name,
      :used_by,
      :subscribers,
      :stargazers,
      :forks_count,
      :contributors,
      :issues,
      :popularity
    )
  end

  # :reek:FeatureEnvy
  # :reek:NestedIterators:
  def output(result)
    Terminal::Table.new do |table|
      table.headings = [
        'gem', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues', 'popularity'
      ]
      result.keys.each do |gem|
        table << result_parse(result, gem)
      end
    end
  end
end

GemsTop.new.run

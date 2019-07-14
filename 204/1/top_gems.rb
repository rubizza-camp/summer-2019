require 'gems'
require 'yaml'
require 'octokit'
require 'open-uri'
require 'nokogiri'
require 'pry'
require 'terminal-table'
require 'optparse'
require_relative 'filters.rb'

# rubocop:disable Style/MixinUsage
include Filters
# rubocop:enable Style/MixinUsage

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

DEFAULT_GEM_LIST_FILE = 'gems.yaml'.freeze
# :reek:UtilityFunction
# :reek:NilCheck:
# :reek:TooManyStatements
# :reek:NestedIterators:
# :reek:FeatureEnvy
# rubocop:disable Metrics/LineLength
# rubocop:disable Metrics/MethodLength
def parse_options
  options = {}
  optparse = OptionParser.new do |opts|
    opts.on('-f', '--file [STRING]', String, 'Enter the config file to open.') do |file|
      options[:file] = file
    end
    opts.on('-n', '--name [STRING]', String, 'Enter name to filter gems by name') do |name|
      raise 'You enter invalid option. Option :name can be only letter,number or string' if name.nil?

      options[:name_sort] = name
    end
    opts.on('-t', '--top [INTEGER]', Integer, 'Enter number to filter top of gems') do |top|
      raise 'You enter invalid option.Option :top can be only integer number' if top.nil?

      options[:top] = top
    end
  end
  optparse.parse!
  options[:file] ||= DEFAULT_GEM_LIST_FILE
  options
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Metrics/MethodLength

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
# rubocop:disable Style/GuardClause
def load_yaml(file)
  if File.exist?(file)
    YAML.load_file(file)
  else
    raise 'File not exists'
  end
end
# rubocop:enable Style/GuardClause

def info(data, client)
  data.map { |gem| [gem.to_sym, gem_info(gem, client)] }
end

# :reek:TooManyStatements
# rubocop:disable Lint/UselessSetterCall
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
def gem_info(gem, client)
  gem_data = {}
  gem_description = Gems.info(gem)
  uri = (
    gem_description['source_code_uri'] || gem_description['homepage_uri']).sub!(%r{http.*com/}, '')
  begin
    repo = client.repo uri
  rescue Octokit::InvalidRepository
    raise gem.to_s + ' didnt have github repo'
  end
  contributors_count = contributors(uri).css('span.num.text-emphasized').children[2].text.to_i
  used_by_count = dependents(uri).css('.btn-link')[1].text.delete('^0-9').to_i
  gem_data[gem.to_sym] = gem_properties(repo, contributors_count, used_by_count)
end
# rubocop:enable Lint/UselessSetterCall
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize

# rubocop:disable Metrics/MethodLength
# :reek:FeatureEnvy
def gem_properties(repo, contributors_count, used_by_count)
  info = {
    name: repo[:name],
    stargazers: repo[:stargazers_count],
    forks_count: repo[:forks_count],
    issues: repo[:open_issues_count],
    subscribers: repo[:subscribers_count],
    contributors: contributors_count,
    used_by: used_by_count
  }
  info[:popularity] = popularity(info)
  info
end
# rubocop:enable Metrics/MethodLength

# :reek:UtilityFunction
# rubocop:disable Style/CaseEquality
def popularity(info)
  info.values.select { |value| Numeric === value }.reduce(:+)
end
# rubocop:enable Style/CaseEquality

def contributors(uri)
  Nokogiri::HTML(open('https://github.com/' + uri))
end

def dependents(uri)
  Nokogiri::HTML(open('https://github.com/' + uri + '/network/dependents'))
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

run

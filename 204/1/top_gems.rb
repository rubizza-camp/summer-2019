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
  options = options_parse
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

# rubocop:disable Metrics/MethodLength
# :reek:UtilityFunction
# :reek:NilCheck:
# :reek:TooManyStatements
# :reek:NestedIterators:
# :reek:FeatureEnvy
def options_parse
  options = {}
  optparse = OptionParser.new do |opts|
    opts.on('-f', '--file [STRING]', String, 'Enter the config file to open.') do |file|
      options[:file] = file
    end
    opts.on('-n', '--name [STRING]', String, 'Enter name to filter gems by name') do |name|
      raise OptionParser::InvalidOption if name.nil?

      options[:name_sort] = name
    end
    opts.on('-t', '--top [INTEGER]', Integer, 'Enter number to filter top of gems') do |top|
      raise OptionParser::InvalidOption if top.nil?

      options[:top] = top
    end
  end
  optparse.parse!
  options[:file] ||= DEFAULT_GEM_LIST_FILE
  options
end

# rubocop:enable Metrics/MethodLength
# :reek:UtilityFunction
def build_client(access_token)
  client = Octokit::Client.new(access_token: access_token)
  client.user.login
  client
end

def access_token
  puts 'Enter your Github Personal Access Token'
  access_token = gets.chomp
end

# :reek:UtilityFunction
def load_yaml(file)
  YAML.load_file(file)
end

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# rubocop:disable Lint/UselessSetterCall
def info(data, client)
  data.map { |gem| [gem.to_sym, gem_info(gem, client)] }.to_h
end

# :reek:TooManyStatements
def gem_info(gem, client)
  gem_data = {}
  gem_description = Gems.info(gem)
  uri = (
    gem_description['source_code_uri'] || gem_description['homepage_uri']).sub!(%r{http.*com/}, '')
  repo = client.repo uri
  contributors_count = contributors(uri).css('span.num.text-emphasized').children[2].text.to_i
  used_by_count = dependents(uri).css('.btn-link')[1].text.delete('^0-9').to_i
  gem_data[gem.to_sym] = gem_properties(repo, contributors_count, used_by_count)
end
# rubocop:enable Lint/UselessSetterCall
# rubocop:enable Metrics/AbcSize

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

# :reek:UtilityFunction
# rubocop:enable Metrics/MethodLength
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

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
  client = authentication
  options = options_parse
  data = load_yaml(options[:file])
  data = filter_by_name(data, options[:name_sort])
  result = info(data, client)
  result = filter_by_top(result, options[:top])
  result = sort_by_popularity(result)
  puts output(result)
end

private
# rubocop:disable Metrics/MethodLength
# :reek:UtilityFunction
# :reek:NilCheck:
# :reek:TooManyStatements
# :reek:NestedIterators:
def options_parse
  options = {}
  optparse = OptionParser.new do |opts|
    opts.on('-f', '---file [STRING]', String, 'Enter the config file to open.') do |file|
      options[:file] = file
    end
    opts.on('-n', '--name [STRING]', String, 'Enter name to filter gems by name') do |name|
      options[:name_sort] = name
    end
    opts.on('-t', '--top [INTEGER]', Integer, 'Enter number to filter top of gems') do |top|
      options[:top] = top
    end
  end
  optparse.parse!
  options[:file].nil? ? options[:file] = 'gems.yaml' : options[:file]
  options
end
# rubocop:enable Metrics/MethodLength

# :reek:UtilityFunction
def authentication
  client = Octokit::Client.new(access_token: '4a43fd1178ebe4725d4548de777ed5b6beb61fdf')
  client.user.login
  client
end

# :reek:UtilityFunction
def load_yaml(options)
  data = YAML.load_file(options)
  data
end

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize
# :reek:TooManyStatements
def info(data, client)
  gem_data = {}
  data.each do |gem|
    gem_info = Gems.info(gem)
    uri = (gem_info['source_code_uri'] || gem_info['homepage_uri']).sub!(%r{http.*com/}, '')
    repo = client.repo uri
    contributors_count = contributors(uri).css('span.num.text-emphasized').children[2].text.to_i
    used_by_count = dependents(uri).css('.btn-link')[1].text.delete('^0-9').to_i
    info = gem_info(repo, contributors_count, used_by_count)
    gem_data.merge!("#{gem}": info)
  end
  gem_data
end

# rubocop:enable Metrics/AbcSize
# :reek:FeatureEnvy
def gem_info(repo, contributors_count, used_by_count)
  info = {
    name: repo[:name],
    stargazers: repo[:stargazers_count],
    forks_count: repo[:forks_count],
    issues: repo[:open_issues_count],
    subscribers: repo[:subscribers_count],
    contributors: contributors_count,
    used_by: used_by_count,
    popularity: 0
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

# rubocop:disable Metrics/AbcSize, Metrics/LineLength, Security/Open
# rubocop:disable Lint/UselessAssignment, Metrics/MethodLength, Lint/AmbiguousOperator

require 'open-uri'
require 'nokogiri'
require 'json'
require 'yaml'
require 'rubygems'
require 'gems'
require 'terminal-table'
require 'optparse'

# :reek:TooManyStatements
# :reek:NestedIterators
def options_get
  options = { top_gem: nil, name_gem: nil, file: 'gems.yaml' }

  OptionParser.new do |parser|
    parser.on('--top=', '--t=', Integer) do |top|
      puts "I give you #{top} gems"
      options[:top_gem] = top
    end
    parser.on('--name=', '--n=', String) do |name|
      puts "Searching for #{name}"
      options[:name_gem] = name
    end
    parser.on('--file=', '--f=') do |file|
      puts "Take info from #{file}"
      options[:file] = file
    end
  end.parse!
  options
end

# :reek:TooManyStatements
def runner
  options = options_get
  gems = YAML.load_file(options[:file])
  gems = gems['gems'].split(' ')
  gems = options_check(gems, options)
  gems = gems.map { |item| item.delete '-' }
  urls = gems.map { |item| Gems.info(item)['source_code_uri'] }
  html_result = nokogiri_parse_first(urls)
  stats = main_stats(html_result)
  stats = polish_main_stats(gems, stats)
  rows = rating_rows(gems, stats)
  table(rows, options)
end

# :reek:NilCheck
# :reek:TooManyStatements
# :reek:UtilityFunction
def options_check(gem_list, options)
  unless options[:name_gem].nil?
    gem_list = gem_list.select { |item| item.include?(options[:name_gem]) }
  end
  options[:top_gem] = gem_list.length if options[:top_gem].nil?
  gem_list
end

def nokogiri_parse_first(url_list)
  doc = url_list.map { |item| Nokogiri::HTML(open(item)) }
  second_doc = url_list.map { |item| Nokogiri::HTML(open(item + '/network/dependents')) }
  docs = [doc, second_doc]
end

# :reek:TooManyStatements
# :reek:UtilityFunction
def main_stats(main_html)
  stats_hash = { watch: nil, star: nil, fork: nil, contributers: nil, issues: nil, used_by: nil }
  watch_star_fork = main_html[0].map { |item| item.css('a.social-count').text.delete(',').scan(/\d+/) }
  stats_hash[:contributers] = (main_html[0].map { |item| item.css('span.num.text-emphasized')[3].text.delete(',').scan(/\d+/).map(&:to_i) }).flatten
  stats_hash[:issues] = (main_html[0].map { |item| item.css('span.Counter')[0].text.to_i }).flatten
  stats_hash[:used_by] = (main_html[1].map { |item| item.css('.btn-link')[1].text.delete(',').scan(/\d+/).map(&:to_i) }).flatten
  stats_hash[:watch] = (watch_star_fork.map { |item| item.values_at(0).map(&:to_i) }).flatten
  stats_hash[:star] = (watch_star_fork.map { |item| item.values_at(1).map(&:to_i) }).flatten
  stats_hash[:fork] = (watch_star_fork.map { |item| item.values_at(2).map(&:to_i) }).flatten
  stats_hash
end

# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
# :reek:UtilityFunction
# :reek:NestedIterators
def polish_main_stats(gems, stats)
  l = gems.length
  hash = {}
  stat_values = stats.values
  gems.each_with_index do |item, index|
    hash[item] = stat_values.map { |value| value = value[index] }
  end
  hash
end

# :reek:TooManyStatements
# :reek:UtilityFunction
# :reek:NilCheck
# :reek:NestedIterators
def rating_rows(gems, stats)
  rows = []
  gems.each_with_index do |item, index|
    rows[index] = stats[item]
  end
  stats = stats.each_value { |value| value.each { |item| item = 0 if item.nil? } }
  rows.map { |item| item.push(item.sum) }
  rows = rows.map { |item| item.unshift(gems[rows.index(item)]) }
  rows.sort_by! &:last
  rows.reverse!
  rows
end

def table(rows, options)
  stats_id = %i[Gem Watch Star Fork Contributers Issues Used_by Rating]
  num_top = options[:top_gem] - 1
  table = Terminal::Table.new rows: rows[0..num_top], headings: stats_id
  puts table
end
runner

# rubocop:enable Metrics/AbcSize, Metrics/LineLength, Security/Open
# rubocop:enable Lint/UselessAssignment, Metrics/MethodLength, Lint/AmbiguousOperator

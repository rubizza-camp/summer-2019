# rubocop:disable Metrics/AbcSize, Security/Open, Lint/AmbiguousOperator

require 'open-uri'
require 'nokogiri'
require 'json'
require 'yaml'
require 'rubygems'
require 'gems'
require 'terminal-table'
require 'optparse'

# :reek:TooManyStatements
# :reek:UtilityFunction
# :reek:NestedIterators
def fetch_options
  options = { file: 'gems.yaml' }
  OptionParser.new do |parser|
    parser.on('--top=', '-t', Integer) { |args| options[:top] = args }
    parser.on('--name=', '-n', String) { |args| options[:name] = args }
    parser.on('--file=', '-f') { |args| options[:file] = args }
  end.parse!
  options
end

# :reek:TooManyStatements
def runner
  options = fetch_options
  gems = parse_yaml(options[:file])
  gems = filter_by_name(gems, options[:name])
  rows = gems.map do |name|
    url = pick_url(name)
    github_pages = pages(url)
    stats = stats(github_pages)
    create_row(name, stats)
  end
  table(rows, filter_by_top(gems, options[:top]))
end

# :reek:UtilityFunction
def parse_yaml(options)
  YAML.load_file(options)['gems']
end

# :reek:NilCheck
# :reek:UtilityFunction
def filter_by_name(gem_list, name)
  return gem_list if name.nil?

  gem_list.select { |item| item.include?(name) }
end

# :reek:NilCheck
# :reek:UtilityFunction
def filter_by_top(gems, top)
  return gems.length if top.nil?

  top
end

# :reek:UtilityFunction
def pick_url(gem)
  info = Gems.info(gem)
  info['source_code_uri'] || info['homepage_uri']
end

def pages(url)
  main_page = Nokogiri::HTML(open(url))
  dependents_page = Nokogiri::HTML(open(url + '/network/dependents'))
  [main_page, dependents_page]
end

# :reek:TooManyStatements
# :reek:UtilityFunction
def stats(pages)
  main, dependents = pages
  watch_star_fork = main.css('a.social-count').text.delete(',').scan(/\d+/).map(&:to_i)
  {
    contributers: main.css('span.num.text-emphasized')[3].text.delete(',').scan(/\d+/)[0].to_i,
    issues: main.css('span.Counter')[0].text.to_i,
    used_by: dependents.css('.btn-link')[1].text.delete(',').scan(/\d+/)[0].to_i,
    watch: watch_star_fork[0],
    star: watch_star_fork[1],
    fork: watch_star_fork[2]
  }
end

# :reek:UtilityFunction
def create_row(gem, stats)
  row = stats.values.map { |item| item || 0 }
  row.push(row.sum).unshift(gem)
end

# :reek:FeatureEnvy
def table(rows, options)
  stats_id = %i[Gem Watch Star Fork Contributers Issues Used_by Rating]
  (rows.sort_by! &:last).reverse!
  table = Terminal::Table.new rows: rows[0..(options - 1)], headings: stats_id
  puts table
end
runner

# rubocop:enable Metrics/AbcSize, Security/Open, Lint/AmbiguousOperator

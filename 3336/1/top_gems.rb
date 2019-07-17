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

@options = { top_gem: nil, name_gem: nil, file: nil }

OptionParser.new do |parser|
  parser.on('--top=', '--t=', Integer) do |top|
    puts "I give you #{top} gems"
    @options[:top_gem] = top
  end
  parser.on('--name=', '--n=', String) do |name|
    puts "Searching for #{name}"
    @options[:name_gem] = name
  end
  parser.on('--file=', '--f=') do |file|
    puts "Take info from #{file}"
    @options[:file] = file
  end
end.parse!

# :reek:TooManyStatements
def runner
  gems = gem_list
  # p "1.Execute gems: #{gems}"
  check_for_optparse(gems)
  urls = get_url(gems)
  # p "2.Turn them into url's: #{urls}"
  html_result_first = nokogiri_parse_first(urls)
  html_result_second = nokogiri_parse_second(urls)
  gems_stats = main_stats(html_result_first, html_result_second)
  gems_stats = polish_main_stats(gems, gems_stats)
  # p "3.Takin all stats: #{gems_stats}"
  stat_rows = rating_rows(gems, gems_stats)
  # p '4.Calculate rating'
  # p '5.Draw table:'
  table(stat_rows)
end

# :reek:NilCheck
def gem_list
  data = if @options[:file].nil?
           YAML.safe_load(File.read('gems.yaml'))
         else
           YAML.safe_load(File.read(@options[:file]))
         end

  gems = Array.new(data['gems'].delete('-').split(' '))
  gems
end

# :reek:NilCheck
# :reek:TooManyStatements
def check_for_optparse(gem_list)
  unless @options[:name_gem].nil?
    gem_list.each do
      gem_list.delete_if { |item| !item.include?(@options[:name_gem]) }
    end
    p "find #{gem_list.length} gems with name #{@options[:name_gem]}"
  end
  p ' 1.1.Sorting by optional parameters'
  @options[:top_gem] = gem_list.length if @options[:top_gem].nil?
end

# :reek:NilCheck
# :reek:UtilityFunction
def get_url(gem_list)
  arr_url = []
  gem_list.each do |url|
    # p Gems.info(url)
    (arr_url << Gems.info(url)['homepage_uri']) if (Gems.info(url)['source_code_uri']).nil?
  end
  arr_url
end

def nokogiri_parse_first(url_list)
  # p @gem_hash
  doc = []
  url_list.each do |el|
    doc << Nokogiri::HTML(open(el))
    # @second_doc << Nokogiri::HTML(open(el + '/network/dependents'))
  end
  doc
end

def nokogiri_parse_second(url_list)
  second_doc = []
  url_list.each do |el|
    second_doc << Nokogiri::HTML(open(el + '/network/dependents'))
  end
  second_doc
end

# :reek:TooManyStatements
# :reek:UtilityFunction
def main_stats(main_html, sub_html)
  watch_star_fork = []
  contributers = []
  issues = []
  used_by = []
  main_html.each do |el|
    watch_star_fork << el.css('a.social-count').text.delete(' ').delete(',').split("\n").reject(&:empty?).map(&:to_i)
    contributers << el.css('span.num.text-emphasized')[3].text.delete(' ').delete(',').split("\n").reject(&:empty?).map(&:to_i)
    issues << [el.css('span.Counter')[0].text.to_i]
  end
  contributers.each_index { |index| (contributers[index] = [0] if contributers[index].empty?) }
  sub_html.each do |el|
    used_by << [el.css('.btn-link')[1].text.delete(' ').delete("\n").delete(',').to_i]
  end
  stats_arr = Array.new(watch_star_fork.concat(contributers).concat(issues).concat(used_by))
end

# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
# :reek:UtilityFunction
def polish_main_stats(gems, stats)
  l = gems.length
  gems.each_index do |i|
    stats[i] = stats[i].concat(stats[i + l]).concat(stats[i + 2 * l]).concat(stats[i + 3 * l])
  end
  # delete element of stats if element include less then 5(amount of stats) elements
  stats.delete_if { |index| index.length < 5 }
  stats
end

# :reek:TooManyStatements
# :reek:UtilityFunction
def rating_rows(gems, stats)
  arr_rate = []
  rows = []

  gems.each_index do |index|
    arr_rate[index] = stats[index].sum
    stats[index].unshift(gems[index]).push(arr_rate[index])
    rows << stats[index]
  end

  rows.sort_by! &:last
  rows.reverse!
end

def table(rows)
  stats_id = %i[Gem Watch Star Fork Contributers Issues Used_by Rating]
  num_top = @options[:top_gem] - 1
  table = Terminal::Table.new rows: rows[0..num_top], headings: stats_id
  puts table
end
runner

# rubocop:enable Metrics/AbcSize, Metrics/LineLength, Security/Open
# rubocop:enable Lint/UselessAssignment, Metrics/MethodLength, Lint/AmbiguousOperator

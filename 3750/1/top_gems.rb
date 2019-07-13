require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'terminal-table'
require_relative 'gemy'
require_relative 'score'

# :reek:UtilityFunction
# :reek:NestedIterators
def read_file_into_array(array)
  File.open("#{Dir.pwd}/gems.yaml", 'r') do |file|
    file.each_line do |line|
      next if line.chomp == 'gems:'
      array << Gemy.new(line.strip[2..-1])
    end
  end
end

# :reek:TooManyStatements
# :reek:FeatureEnvy
def calculate_all_data(array_of_gems)
  read_file_into_array(array_of_gems)
  array_of_gems.each(&:find_stats)

  scores = Score.new(array_of_gems)
  scores.calculate_overall_score

  array_of_gems.sort! { |a_gem, b_gem| b_gem.overall_score <=> a_gem.overall_score }
end

# rubocop:disable Metrics/LineLength, Metrics/AbcSize, Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength, Metrics/PerceivedComplexity
# :reek:TooManyStatements
# :reek:FeatureEnvy
def show_gems(array_of_gems, top_number = array_of_gems.size, name = '')
  rows = []
  table = Terminal::Table.new headings: ["Gem\nname", 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
  count = 0
  array_of_gems.each do |gem|
    if (gem.gem_name.include? name) && !name.empty?
      rows << [gem.gem_name, gem.stats[:used], gem.stats[:watched], gem.stats[:stars], gem.stats[:forks], gem.stats[:contributors], gem.stats[:issues]]
      next
    elsif name.empty?
      rows << [gem.gem_name, gem.stats[:used], gem.stats[:watched], gem.stats[:stars], gem.stats[:forks], gem.stats[:contributors], gem.stats[:issues]]
      count += 1
      break if count == top_number.to_i
    end
  end
  table.rows = rows
  puts "Top gems with word '#{name}' in it:" unless name.empty?
  puts "Top #{top_number} gems:" if name.empty?
  puts table
end
# rubocop:enable Metrics/LineLength, Metrics/AbcSize, Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength, Metrics/PerceivedComplexity

# ------------------------------------------------------------------------

options = {
  pararameter: nil
}

gems = []

OptionParser.new do |parser|
  parser.on('--file=file_name') do |file_name|
    options[:par] = file_name
    puts "Path to directory of gems list is:\n" + Dir.pwd + '/gems.yaml'
    puts "\nfile contents:\n"
    system('cat', Dir.pwd + '/gems.yaml')
    exit
  end
  parser.on('--top=number') do |number|
    options[:par] = number.to_i
    calculate_all_data(gems)
    show_gems(gems, options[:par])
    exit
  end
  parser.on('--name=gem_name') do |gem_name|
    options[:par] = gem_name
    calculate_all_data(gems)
    show_gems(gems, nil, options[:par])
    exit
  end
end.parse!

calculate_all_data(gems)
show_gems(gems)

require_relative 'gem_info.rb'
require 'rubygems'
require 'yaml'
require 'optparse'

DEFAULT_GEMS_FILE = 'gems.yml'.freeze

# Main class, which open file with gems,
# call GemInfo class to get information about gems,
# check options and print all information on console.
class TopGems
  def initialize
    @gems = {}
    @options = {}
    parse_options
  end

  def run
    gem_names = open_file
    check_name_option(gem_names)

    gem_names.each do |gem_name|
      @gems[gem_name] = GemInfo.new(gem_name).call
    end
    sort_and_print
  end

  private

  # :reek:TooManyStatements and :reek:NestedIterators
  def parse_options
    OptionParser.new do |opts|
      opts.on('-t', '--top=top', Integer) { |top| @options[:top] = top }
      opts.on('-n', '--name=name', String) { |name| @options[:name] = name }
      opts.on('-f', '--file=file', String) { |file| @options[:file] = file }
    end.parse!
  end

  def open_file
    file_name = @options[:file] || DEFAULT_GEMS_FILE
    file = YAML.load_file(file_name)
    file['gems'].uniq
  end

  def check_name_option(gem_names)
    return unless @options[:name]

    gem_names.select! { |name| name.include?(@options[:name]) }
    puts "No gems with name #{@options[:name]} found" if gem_names.empty?
  end

  def sort_and_print
    max_name_length = @gems.keys.map(&:length).max
    sorted_gems = @gems.sort_by { |_, info| -info[:rating] }
    print_gems_info(sorted_gems, max_name_length)
  end

  def print_gems_info(sorted_gems, max_name_length)
    sorted_gems = sorted_gems.take(@options[:top]) if @options[:top]
    sorted_gems.each do |gem_name, info|
      info.transform_values!(&:to_s)
      print_table(max_name_length, gem_name, info)
    end
  end

  # :reek:FeatureEnvy
  def print_table(max_name_length, gem_name, info)
    puts "#{gem_name.ljust(max_name_length)} " \
    "| used by #{info[:used_by].rjust(7)} " \
    "| watched by #{info[:watches].rjust(6)} " \
    "| #{info[:stars].rjust(6)} stars " \
    "| #{info[:forks].rjust(6)} forks " \
    "| #{info[:contributors].rjust(6)} contributors " \
    "| #{info[:issues].rjust(6)} issues |"
  end
end

TopGems.new.run

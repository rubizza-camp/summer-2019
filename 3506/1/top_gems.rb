require_relative 'gem_info.rb'
require 'rubygems'
require 'yaml'
require 'optparse'

DEFAULT_GEMS_FILE = 'gems.yml'.freeze

OPTIONS_MAP = {
  top:  ['-t', '--top=top',   Integer],
  name: ['-t', '--name=name', String],
  file: ['-f', '--file=file', String]
}.freeze

# :reek:MissingSafeMethod { exclude: [ parse_options!, parse_option! ] }
# :reek:InstanceVariableAssumption
# Main class, which open file with gems,
# call GemInfo class to get information about gems,
# check options and print all information on console.
class TopGems
  def initialize
    @gems = {}
    @options = {}
  end

  def run
    parse_options!
    gem_names
    check_name_option
    fill_gems_hash
    sort_and_print
  end

  private

  def parse_options!
    option_parser = OptionParser.new
    OPTIONS_MAP.map do |option_name, match_pattern|
      parse_option!(option_parser, match_pattern, option_name)
    end
    option_parser.parse!
  end

  def parse_option!(option_parser, match_pattern, option_name)
    option_parser.on(*match_pattern) { |value| @options[option_name] = value }
  end

  def gem_names
    return @gem_names if defined?(@gem_names)

    file_name = @options[:file] || DEFAULT_GEMS_FILE
    file = YAML.load_file(file_name)
    @gem_names = file['gems'].uniq
  end

  def check_name_option
    return unless @options[:name]

    gem_names.select! { |name| name.include?(@options[:name]) }
    puts "No gems with name #{@options[:name]} found" if gem_names.empty?
  end

  def fill_gems_hash
    gem_names.each do |gem_name|
      @gems[gem_name] = GemInfo.new(gem_name).call
    end
  end

  def sort_and_print
    max_name_length = @gems.keys.map(&:length).max
    sorted_gems = @gems.sort_by { |_, info| -info[:rating].to_i }
    print_gems_info(sorted_gems, max_name_length)
  end

  def print_gems_info(sorted_gems, max_name_length)
    sorted_gems = sorted_gems.take(@options[:top]) if @options[:top]
    sorted_gems.each do |gem_name, info|
      info.transform_values!(&:to_s)
      if info.empty?
        puts "#{gem_name} | no gem info found"
      else
        print_info(max_name_length, gem_name, info)
      end
    end
  end

  # :reek:FeatureEnvy
  def print_info(max_name_length, gem_name, info)
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

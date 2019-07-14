# rubocop:disable Lint/MissingCopEnableDirective

# This class runs the program

require 'optparse'
require_relative 'yml_parser.rb'
require_relative 'github_url_finder.rb'
require_relative 'github_collector.rb'
require_relative 'terminal_output.rb'

commands = {}

OptionParser.new do |opts|
  opts.on('-t', '--top=NUMBER', Integer, 'Show NUMBER from top') do |top|
    commands[:top] = top
  end

  opts.on('-n', '--name=NAME', String, 'Filter list by NAME') do |name|
    commands[:name] = name
  end

  opts.on('-f', '--file=PATH', String, 'Path to gems list if PATH') do |path|
    commands[:file] = path
  end
end.parse!

class TopGems
  attr_reader :commands, :gems_hash, :gems_github_urls_hash, :gems_data_array, :output

  def initialize(commands)
    @commands = commands
    parse_yml(commands[:file], commands[:top], commands[:name])
    find_gems_github_urls
    collect_gems_data
    form_the_output
  end

  protected

  # :reek:NilChec
  # :reek:TooManyInstanceVariables
  def parse_yml(file, top, name)
    file = 'gems.yml' if file.nil?
    if name.nil?
      @gems_hash = YmlParser.new(file).gems_hash.values.flatten[0...top]
    else
      # rubocop:disable Metrics/LineLength
      @gems_hash = YmlParser.new(file).gems_hash.values.flatten[0...top].select { |gem| gem.include?(name) }
    end
  end

  def find_gems_github_urls
    @gems_github_urls_hash = GitHubUrlFinder.new(gems_hash).gems_github_urls_hash
  end

  def collect_gems_data
    @gems_data_array = GitHubCollector.new(gems_github_urls_hash).gems_data_array
  end

  def form_the_output
    @output = TerminalOutput.new(gems_data_array).output
    puts output
  end
end

run_the_program = TopGems.new(commands)
run_the_program

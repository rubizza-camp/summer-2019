# frozen_string_literal: true

require 'yaml'
require 'nokogiri'
require 'gems'
require 'httparty'
require 'terminal-table'
require 'optparse'
require_relative 'githubparser'
# TopRubyGems class shows you rating of gems
class TopGems
  attr_reader :options, :gems_list
  attr_accessor :parser

  def parse_cli_options
    @options = { input_path_to_file: 'data/gems.yml' }
    optparse = OptionParser.new do |opts|
      opts.on('-n', '--name [STRING]', String) { |args| options[:input_name] = args.strip.chomp }
      opts.on('-t', '--top= [INTEGER]', Integer) { |args| options[:input_qty] = args }
      opts.on('-f', '--file= [STRING]', String) { |args| options[:input_path_to_file] = args.strip.chomp }
    end
    optparse.parse!(into: @options)
  end

  def read_list
    list = YAML.load_file(options[:input_path_to_file])['gems']
    list.select! { |gem_name| gem_name.include?(options[:input_name].to_s) } if options[:input_name]
    @gems_list = list.map(&:downcase).uniq.compact
  end

  def fetch_data
    @gems = parser.fetch_data(gems_list)
  end

  def table
    header = ['Gem', 'used by', 'watches', 'stars', 'forks', 'contributors', 'issues', 'rank']
    rows = @gems.sort_by! { |gem_info| gem_info[:rank] }.reverse
    rows = rows.map { |gem_info| gem_info.values_at(:name, :used_by, :watches, :stars, :forks, :contributors, :issues, :rank) }
    rows = rows.take(options[:input_qty]) if options[:input_qty]
    Terminal::Table.new(headings: header, rows: rows)
  end
end

top_gems = TopGems.new
top_gems.parse_cli_options
top_gems.read_list
top_gems.parser = GithubParser.new
top_gems.fetch_data
puts top_gems.table

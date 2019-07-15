# frozen_string_literal: true

require_relative 'findgem.rb'
require 'yaml'
require 'terminal-table'
require 'optparse'

# :reek:UtilityFunction
# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:TooManyInstanceVariables
class TopGems
  HEADING_TABLE = ['name', 'used by', 'watcheds', 'stars', 'forks', 'contributors', 'issues']
  STYLES_FOR_TABLE = {
    border_top: true, border_bottom: true, border_x: '<', border_i: '>'
  }

  attr_reader :threads, :list

  def initialize
    @threads = []
    @list = []
    @params = load_options
    @yaml_file = load_yml
    @gem_list = @params[:name] ? select_name : @yaml_file['gems']
    @repos = @params[:top] ? sort_top(load_gems) : load_gems
    show
  end

  def sort_top(gems)
    range = [@params[:top], gems.size].min
    gems.sort_by(&:stars)[-range..-1].reverse
  end

  def load_yml
    YAML.load_file(File.open(@params[:file]))
  end

  def load_options
    options = {}
    OptionParser.new do |opts|
      opts.on('--name[=OPTIONAL]', String, 'gem name')
      opts.on('--file[=OPTIONAL]', String, 'name file')
      opts.on('--top[=OPTIONAL]', Integer, 'show top')
    end.parse!(into: options)
    options
  end

  def show
    tb_stats = @repos.map do |repo|
      [
        repo.name, repo.used_by_stat,
        repo.watched_by, repo.stars,
        repo.forks, repo.contributors_stat,
        repo.issues
      ]
    end
    print_table(tb_stats)
  end

  def print_table(tb_data)
    table = Terminal::Table.new headings: HEADING_TABLE, rows: tb_data, style: STYLES_FOR_TABLE
    puts table
  end

  def select_name
    @yaml_file['gems'].select { |gem| gem.include? @params[:name] }
  end

  def load_gems
    @gem_list.map do |gem|
      @threads << Thread.new do
        gem_data = GemsAddres.new(gem)
        gem_data.call gem
        @list << gem_data
      end
    end
    @threads.each(&:join)
    @list
  end
end

TopGems.new

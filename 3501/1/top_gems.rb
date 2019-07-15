require_relative 'git_get.rb'
require 'yaml'
require 'terminal-table'
require 'optparse'

#:reek:FeatureEnvy
#:reek:TooManyInstanceVariables
class TopGems
  def initialize
    @threads = []
    @list = []
    @params = load_options
    @yaml_file = yaml_from_file
    @gem_list = @params[:name] ? select_name : @yaml_file['gems']
    @repos = @params[:top] ? sort_top(load_gems) : load_gems
    show
  end

  private

  attr_accessor :threads, :list, :gem_list, :params, :yaml_file, :repos

  #:reek:TooManyStatements
  #:reek:UtilityFunction
  def load_options
    options = {}
    OptionParser.new do |opts|
      opts.on('--name[=OPTIONAL]', String, 'pick by name')
      opts.on('--file[=OPTIONAL]', String, 'gems file name')
      opts.on('--top[=OPTIONAL]', Integer, 'showing first in raiting')
    end.parse!(into: options)
    options
  end

  def show
    table_str = @repos.map do |repo|
      [
        repo.name.to_s, "used by #{repo.used_by}",
        "watched by #{repo.watched_by}", "#{repo.stars} stars",
        "#{repo.forks} forks", "#{repo.contributors} contributors",
        "#{repo.issues} issues"
      ]
    end
    print_table(table_str)
  end

  def print_table(str_table)
    terminal = Terminal::Table.new do |tab|
      tab.rows = str_table
      tab.style = { border_top: false, border_bottom: false }
    end
    puts terminal
  end

  def select_name
    @yaml_file['gems'].select { |gem| gem.include? @params[:name] }
  end

  #:reek:TooManyStatements
  def load_gems
    @gem_list.map do |gem|
      @threads << Thread.new do
        @list << GetGemDataFromGit.call(gem)
      end
    end
    @threads.each(&:join)
    @list
  end

  def sort_top(gems)
    limit_range = [@params[:top], gems.size].min
    gems.sort_by(&:used_by)[-limit_range..-1].reverse
  end

  def yaml_from_file
    YAML.load_file(File.open(@params[:file]))
  end
end

TopGems.new

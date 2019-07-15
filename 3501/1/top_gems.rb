require_relative 'git_get.rb'
require 'yaml'
require 'terminal-table'
require 'optparse'

class TopGems
  def initialize
    options = {}
    @threads = []
    load_options(options)
    @yaml_file = yaml_from_file(options)
    @gem_list = options[:name] ? select_name(options) : @yaml_file['gems']
    @repos = options[:top] ? sort_top(load_gems, options) : load_gems
    show
  end

  private

  attr_reader :threads, :gem_list, :params, :yaml_file, :repos

  def load_options(options)
    OptionParser.new do |opts|
      opts.on('--name[=OPTIONAL]', String, 'pick by name')
      opts.on('--file[=OPTIONAL]', String, 'gems file name')
      opts.on('--top[=OPTIONAL]', Integer, 'showing first in raiting')
    end.parse!(into: options)
  end

  def show
    table_str = @repos.map do |repo|
      create_string_table(repo)
    end
    print_table(table_str)
  end

  def create_string_table(repo)
    [
      repo.git_data[:name].to_s, "used by #{repo.git_data[:used_by]}",
      "watched by #{repo.git_data[:watched_by]}", "#{repo.git_data[:stars]} stars",
      "#{repo.git_data[:forks]} forks", "#{repo.git_data[:contributors]} contributors",
      "#{repo.git_data[:issues]} issues"
    ]
  end

  def print_table(str_table)
    terminal = Terminal::Table.new do |tab|
      configure_tab(str_table, tab)
    end
    puts terminal
  end

  def configure_tab(str_table, tab)
    tab.rows = str_table
    tab.style = { border_top: false, border_bottom: false }
  end

  def select_name(options)
    @yaml_file['gems'].select { |gem| gem.include? options[:name] }
  end

  def load_gems
    list = []
    @gem_list.map do |gem|
      @threads << Thread.new do
        list << GetGemDataFromGit.call(gem)
      end
    end
    wait_for_threads(list)
  end

  def wait_for_threads(list)
    @threads.each(&:join)
    list
  end

  def sort_top(gems, options)
    limit_range = [options[:top], gems.size].min
    gems.sort_by { |element| element.git_data[:used_by] }[-limit_range..-1].reverse
  end

  def yaml_from_file(options)
    YAML.load_file(File.open(options[:file]))
  end
end

TopGems.new

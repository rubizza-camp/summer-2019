require 'yaml'
require 'terminal-table'
require './git_get.rb'

class TopGems
  def initialize(params)
    @params = params.map { |param| param.split('=') }.to_h
    @yaml_file = yaml_from_file
    @gem_list = @params['--name'] ? select_name : @yaml_file['gems']
    @repos = @params['--top'] ? top(gems) : gems
    show
  end

  #:reek:FeatureEnvy
  def show
    table_str = @repos.map do |repo|
      [
        repo.name.to_s, "used by #{repo.used_by}",
        "watched by #{repo.watched_by}", "#{repo.stars} stars",
        "#{repo.forks} forks", "#{repo.contributors} contributors",
        "#{repo.issues} issues"
      ]
    end
    print_terminal table_str
  end

  #:reek:FeatureEnvy
  def print_terminal(str_table)
    style = { border_top: false, border_bottom: false }
    terminal = Terminal::Table.new do |tab|
      tab.rows = str_table
      tab.style = style
    end
    puts terminal
  end

  private

  def select_name
    @yaml_file['gems'].select { |gem| gem.include? @params['--name'] }
  end

  #:reek:FeatureEnvy
  #:reek:TooManyStatements
  def gems
    threads = []
    list = []
    @gem_list.map do |gem|
      threads << Thread.new do
        list << GitGet.new(gem)
      end
    end
    threads.each(&:join)
    list
  end

  def top(gems)
    gems.sort_by(&:used_by)[-@params['--top'].to_i..-1].reverse
  end

  def yaml_from_file
    YAML.safe_load(File.open(@params['--file']))
  end
end

TopGems.new ARGV

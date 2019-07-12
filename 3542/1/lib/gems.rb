require 'yaml'
require 'terminal-table'
require 'pry'
require_relative 'repo'

class Gems
  def initialize params
    @params = params.map { |param| param.split('=') }.to_h

    @gem_list = @params['--name'] ? filter_by_name(gem_list) : gem_list['gems']

    @repos = @params['--top'] ? top(gems) : gems
  end

  def show
    table_rows = @repos.map do |repo|
      ["#{repo.name}", "used by #{repo.used_by}", "watched by #{repo.watched_by}", "#{repo.stars} stars", "#{repo.forks} forks", "#{repo.contributors} contributors", "#{repo.issues} issues"]
    end
    table = Terminal::Table.new rows: table_rows
    puts table
  end

  private

  def filter_by_name gem_list
    gem_list['gems'].select { |gem| gem.include? @params['--name'] }
  end

  def gems
    @gem_list.map { |gem| Repo.new gem }
  end

  def top gems
    gems.sort_by { |gem| gem.used_by }[(-@params['--top'].to_i)..-1].reverse
  end

  def gem_list
    YAML.load file @params['--file']
  end

  def file path
    File.open(File.expand_path path)
  end
end

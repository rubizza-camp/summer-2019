require 'yaml'
require_relative 'parser'
require 'terminal-table'

class TopGems
  def initialize(params)
    @params = params.map { |param| param.split('=') }.to_h
    @yml_file_name = @params['--file'] ? gem_names : default_gem_names
    @gem_list = @params['--name'] ? select_gem_name : @yml_file_name
    @repos = @params['--top'] ? top : ruby_gem_stat_objects
    show_statistic
  end

  def gem_names
    YAML.load_file(@params['--file'])['gems']
  end

  # :reek:UtilityFunction
  def default_gem_names
    YAML.load_file('ruby_gems.yaml')['gems']
  end

  def select_gem_name
    @yml_file_name.select { |gem_name| gem_name.include? @params['--name'] }
  end

  #:reek:FeatureEnvy
  def ruby_gem_stat_objects
    parsers = @gem_list.map do |name|
      Parser.new(gem_name: name)
    end
    parsers.map(&:create_statistic).sort_by { |obj| obj.used_by / obj.stars }.reverse
  end

  def object_to_row
    @repos.map(&:strings)
  end

  # :reek:TooManyStatements
  def show_statistic
    rows = []
    object_to_row.each { |value| rows << value }
    table = Terminal::Table.new do |tab|
      tab.rows = rows
      tab.style = { border_top: false, border_bottom: false }
    end
    puts table
  end

  def top
    ruby_gem_stat_objects[0..(@params['--top'].to_i - 1)]
  end
end

TopGems.new ARGV

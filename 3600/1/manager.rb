require 'yaml'
require_relative 'parser'
require_relative 'gems_data'
require_relative 'table_creator'

class Manager
  def initialize(params)
    @params = params.map { |param| param.split('=') }.to_h
    @yml_file_name = @params['--file'] ? gem_names : default_gem_names
    @gem_list = @params['--name'] ? select_gem_name : @yml_file_name
    @repos = @params['--top'] ? top : repository_objects
  end

  def gem_names
    YAML.load_file(@params['--file'])['gems']
  end

  #:reek:UtilityFunction
  def default_gem_names
    YAML.load_file('gems.yaml')['gems']
  end

  def select_gem_name
    @yml_file_name.select { |gem_name| gem_name.include? @params['--name'] }
  end

  #:reek:FeatureEnvy
  def repository_objects
    parsers = @gem_list.map do |name|
      Parser.new(gem_name: name)
    end
    parsers.map(&:create_statistic).sort_by { |obj| obj.used_by / obj.stars }.reverse
  end

  def save_in_strings
    @repos.map do |obj|
      GemsData.new(obj: obj).strings
    end
  end

  def out_in_command_line
    TableCreator.new.create(save_in_strings)
  end

  def top
    repository_objects[0..(@params['--top'].to_i - 1)]
  end
end

require 'yaml'
require 'optparse'
require_relative 'parserrepository.rb'
require_relative 'repository_preseter.rb'
require_relative 'create_table.rb'
require_relative 'optparse.rb'
# :reek:InstanceVariableAssumption
class Coordinator
  include OptParser
  # :reek:ToManyStatements
  def run
    @options = parse_options
    @gem_list = @options[:sort_name] ? select_gem_name : gem_names
    @repos = @options[:top] ? top_gems : repository_objects
    out_in_command
  end

  def gem_names
    YAML.load_file(@options[:file])['gems']
  end

  def select_gem_name
    gem_names.select { |gem_name| gem_name.include? @options[:sort_name] }
  end

  # :reek:FeatureEnvy
  def repository_objects
    parsers = @gem_list.map do |name|
      ParserRepository.new(gem_name: name)
    end
    parsers.map(&:create_statistic).sort_by { |obj| obj.used_by / obj.stars }.reverse
  end

  def top_gems
    repository_objects[0..(@options[:top].to_i - 1)]
  end

  def out_in_command
    save_in_strings = @repos.map do |obj|
      RepositoryPreseter.new(obj: obj).strings
    end
    PrintTable.new.create(save_in_strings)
  end
end

require 'yaml'
require 'optparse'
require_relative 'parserrepository.rb'
require_relative 'repository_preseter.rb'
require_relative 'create_table.rb'
require_relative 'optparse.rb'
# :reek:InstanceVariableAssumption
class Coordinator
  include OptParser

  attr_reader :options, :gem_list, :repos
  # :reek:ToManyStatements
  def run
    @options = parse_options
    @gem_list = @options[:sort_name] ? [@options[:sort_name]] : gem_names
    @repos = @options[:top] ? top_gems : order_repository
    print_table
  end

  def gem_names
    YAML.load_file(@options[:file])['gems']
  end
  # :reek:FeatureEnvy

  def repository_objects
    parsers = @gem_list.map do |name|
      ParserRepository.new(gem_name: name)
    end
    parsers.map(&:create_statistic)
  end

  def order_repository
    order_rep = repository_objects.sort_by do |obj|
      obj.used_by + (obj.stars * 2)
    end
    order_rep.reverse
  end

  def top_gems
    filter = (@options[:top].to_i - 1)
    order_repository[0..filter]
  end

  def print_table
    presented_repositories = @repos.map do |obj|
      RepositoryPreseter.new(repository: obj).present_repo_info
    end
    PrintTable.new.show_table(presented_repositories)
  end
end

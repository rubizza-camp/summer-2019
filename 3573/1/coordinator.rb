require 'yaml'
require 'optparse'
require_relative 'parserrepository'
require_relative 'repository_preseter'
require_relative 'create_table'
require_relative 'optparse'
# :reek:InstanceVariableAssumption
class Coordinator
  include OptParser

  attr_reader :options, :gem_list, :repos, :order_rep
  # :reek:ToManyStatements
  def run
    @options = parse_options
    @gem_list = options[:sort_name] ? [options[:sort_name]] : gem_names
    @repos = options[:top] ? top_gems : order_repositories
    print_table
  end

  def gem_names
    YAML.load_file(options[:file])['gems']
  end
  # :reek:FeatureEnvy

  def repository_objects
    parsers = gem_list.map do |name|
      ParserRepository.new(gem_name: name)
    end
    parsers.map(&:fetch_gem_info)
  end

  def order_repositories
    @order_rep ||= repository_objects.sort_by do |obj|
      obj.used_by + (obj.stars * 2)
    end
    order_rep.reverse
  end

  def top_gems
    top_number = (options[:top].to_i - 1)
    order_repositories[0..top_number]
  end

  def print_table
    presented_repositories = repos.map do |repository|
      RepositoryPreseter.new(repository: repository).present_repo_info
    end
    PrintTable.new.show_table(presented_repositories)
  end
end

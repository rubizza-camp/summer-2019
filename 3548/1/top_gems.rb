require 'yaml'
require 'dotenv'
require_relative 'table_creation'
require 'optparse'

class TopGems
  def initialize(gem)
    @github_parser = Parser.new(gem)
    @options = self.class.load_options
  end

  def create_top
    gem_top = []
    load_to_search_list.each { |name| gem_top << @github_parser.parse(name) }
    TableCreation.new(gem_top, @options[:top], @options[:name]).print_top
  end

  def self.load_options
    options = {}
    options[:file] = 'gems.yaml'
    OptionParser.new do |opts|
      fill_options(opts)
    end.parse!(into: options)
    options
  end

  def self.fill_options(opts)
    opts.on('--name[=OPTIONAL]', String, 'pick by name')
    opts.on('--file[=OPTIONAL]', String, 'gems file name')
    opts.on('--top[=OPTIONAL]', Integer, 'showing first in raiting')
  end

  private

  def load_to_search_list
    YAML.safe_load(File.read(@options[:file] ||= 'gems.yaml'))['gems']
  end
end

Dotenv.load
top_of_tops = TopGems.new(ENV['GITHUB_TOKEN'])
top_of_tops.create_top

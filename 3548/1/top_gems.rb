require 'yaml'
require 'dotenv'
require_relative 'hard_core.rb'

class Top
  def initialize(life)
    @github_parser = Parser.new(life)
    @parameters = load_parameters
  end

  def create_top
    gem_top = []
    load_to_search_list.each { |name| gem_top << @github_parser.parse(name) }
    TerminalInformation.new(gem_top, @parameters[:top], @parameters[:name]).print_top
  end

  private

  def load_to_search_list
    YAML.safe_load(File.read(@parameters[:file] ||= 'gems.yml'))['gems']
  end

  def load_parameters
    ARGV.each_with_object({}) do |parameter, hash|
      split = parameter.delete('-').split('=')
      hash[split.first.to_sym] = split.last
    end
  end
end

Dotenv.load
top_of_tops = Top.new(ENV['GITHUB_TOKEN'])
top_of_tops.create_top

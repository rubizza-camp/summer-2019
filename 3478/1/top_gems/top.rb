require 'yaml'
require 'dotenv'
require_relative 'github_parser.rb'
require_relative 'terminal_output.rb'

class Top
  def initialize(token)
    @github_parser = GitHubParser.new(token)
    @parameters = load_parameters
  end

  def create_top
    gem_top = []
    load_to_search_list.each { |name| gem_top << @github_parser.parse(name) }
    TerminalOutput.new(gem_top, @parameters[:top], @parameters[:name]).print_top
  end

  private

  def load_to_search_list
    YAML.safe_load(File.read(@parameters[:file] ||= 'gems.yml'))['gems']
  end

  def load_parameters
    ARGV.each_with_object({}) do |parametr, hash|
      split = parametr.delete('-').split('=')
      hash[split.first.to_sym] = split.last
    end
  end
end

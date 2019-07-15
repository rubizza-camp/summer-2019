require 'yaml'
require 'dotenv'
require_relative 'github_parser.rb'
require_relative 'terminal_output.rb'

class Top
  def initialize(token)
    @github_parser = GitHubParser.new(token)
    @gem_top = []
    @parameters = { top: nil, name: nil, file: nil }
  end

  def create_top
    load_parameters
    load_to_search_list.each { |name| @gem_top << @github_parser.parse(name) }
    TerminalOutput.new(@gem_top, @parameters[:top], @parameters[:name]).print_top
  end

  private

  def load_to_search_list
    YAML.safe_load(File.read(@parameters[:file]))['gems']
  end

  def load_parameters
    @parameters[:top]  = ARGV.grep(/--top=(\d+)/).to_s[8..-3]
    @parameters[:name] = ARGV.grep(/--name=(.+)/).to_s[9..-3]
    @parameters[:file] = ARGV.grep(/--file=(.+)/).to_s[9..-3]
    @parameters[:file] ||= 'gems.yml'
  end
end

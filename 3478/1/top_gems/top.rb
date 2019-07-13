require 'yaml'
require 'dotenv'
require_relative 'gem_item.rb'
require_relative 'github_parser.rb'
require_relative 'terminal_output.rb'

class Top
  def initialize(token)
    @github_parser = GitHubParser.new(token)
    @terminal = TerminalOutput.new
    @gem_top = []
  end

  def create_top
    load_parametrs
    search_list = load_to_search_list(@parameters[:file])
    search_list.each { |name| @gem_top << @github_parser.parce(name) }
    @gem_top.sort_by!(&:total_score)
    @terminal.print_top(@gem_top.reverse!, @parameters[:top], @parameters[:name])
  end

  def load_parametrs
    @parameters = { top: nil, name: nil, file: nil }
    @parameters[:top]  = ARGV.grep(/--top=(\d+)/).to_s[8..-3]
    @parameters[:name] = ARGV.grep(/--name=(.+)/).to_s[9..-3]
    @parameters[:file] = ARGV.grep(/--file=(.+)/).to_s[9..-3]
  end

  def load_to_search_list(path)
    path ||= 'gems.yml'
    YAML.safe_load(File.read(path))['gems']
  end
end

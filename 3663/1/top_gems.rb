# This class runs the program

require_relative 'yml_parser.rb'
require_relative 'github_url_finder.rb'
require_relative 'github_collector.rb'
require_relative 'option_parser.rb'
require_relative 'terminal_output.rb'

class TopGems < OptionParserSetter
  attr_reader :gems, :gems_github_urls_hash, :gems_data_array, :output

  def run_the_program
    set_commands
    select_gems(commands[:file], commands[:top], commands[:name])
    find_gems_github_urls
    collect_gems_data
    form_the_output
  end

  private

  def select_gems(file, top, name)
    @gems = YmlParser.new.parse_yml(file).values.flatten[0...top].select do |gem|
      gem.include?(name)
    end
  end

  def find_gems_github_urls
    @gems_github_urls_hash = GitHubUrlFinder.new.look_for_gem_github_url(gems)
  end

  def collect_gems_data
    @gems_data_array = GitHubCollector.new.collect_data_from_github(gems_github_urls_hash)
  end

  def form_the_output
    @output = TerminalOutput.new.generate_table(gems_data_array)
    puts output
  end
end

TopGems.new.run_the_program

require 'rubygems'
require 'terminal-table'
require_relative 'github_stat_parser.rb'
require_relative 'github_html_parser.rb'
require_relative 'data_output.rb'
require_relative 'file_reader.rb'

class TopGems
  def run
    hash_gems = {}
    hash_names = []
    add_args = {}
    add_args = CommandLineParser.get_args(add_args)
    hash_names = FileReader.new.read_yml_file(hash_names, add_args['file'])
    gems_data = fetch_gems(hash_names, hash_gems)
    DataOutput.draw_table(gems_data, add_args)
  end

  def fetch_gems(hash_names, hash_gems)
    hash_names.each do |name_of_gem|
      url = GithubRepoSearcher.search(name_of_gem)
      next unless url && url != ''
      hash_stats = GithubStatParser.perform(url)
      hash_stats ? hash_gems[name_of_gem] = hash_stats : hash_gems.delete(name_of_gem)
    end
    hash_gems
  end
end

TopGems.new.run

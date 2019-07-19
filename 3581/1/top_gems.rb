require 'rubygems'
require 'terminal-table'
require_relative 'github_stat_parser.rb'
require_relative 'github_html_parser.rb'
require_relative 'data_output.rb'
require_relative 'file_reader.rb'

class TopGems
  class << self
    def run
      add_args = CommandLineParser.get_args
      arr_names = FileReader.new.read_yml_file(add_args['file'])
      gems_data = fetch_gems(arr_names)
      DataOutput.draw_table(gems_data, add_args)
    end

    def fetch_gems(arr_names)
      arr_names.each_with_object({}) do |name_of_gem, hash_gems|
        url = GithubRepoSearcher.search(name_of_gem)
        next unless url && url != ''
        hash_stats = GithubStatParser.perform(url)
        hash_stats ? hash_gems[name_of_gem] = hash_stats : hash_gems.delete(name_of_gem)
      end
    end
  end
end

TopGems.run

require 'terminal-table'
require_relative 'gem_sorter.rb'

class DataOutput
  class << self
    def draw_table(hash_gems, add_args)
      CommandLineParser.find_gem_by_name(hash_gems, add_args) if add_args['name']
      sorte_gems = GemSorter.sort_top(hash_gems, add_args)
      puts fill_table(sorte_gems)
    end

    private

    def fill_table(hash_gems)
      Terminal::Table.new do |top|
        pass_params(top, hash_gems)
      end
    end

    def pass_params(top, hash_gems)
      hash_gems.each do |name_of_gem, gems_param|
        top << [name_of_gem, 'used by ' "#{gems_param['used_by']}", 'watched by ' "#{gems_param['watch']}",
                "#{gems_param['star']} " 'stars', "#{gems_param['fork']} " 'forks',
                "#{gems_param['contrib']} " 'contributors', "#{gems_param['issues']} " 'issues']
      end
    end
  end
end

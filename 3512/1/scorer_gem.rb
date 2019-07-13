require 'yaml'
require 'table_print'
require_relative './inf_gem.rb'

class ScorerGem
  def call(opt)
    list = load_list(opt[:file])
    gem_names = filter_name(list, opt[:name])
    gems_array = gems_info(gem_names)
    gems_array.sort_by!(&:popularity).reverse!
    gems_array = take_top(gems_array, opt[:top])
    tp gems_array, :name, { used_by: { display_name: 'used by' } },
       { watch: { display_name: 'Watched By' } },
       :star, :fork, { contrib: { display_name: 'Contributors' } },
       :issues
  end

  def load_list(file)
    YAML.load_file(file)
  rescue Errno::ENOENT
    puts 'file must exist'
    exit
  end

  def filter_name(list, name)
    list['gems'].find_all { |gem| gem.match(name) }
  end

  def take_top(arr, top = nil)
    top ||= arr.size
    begin
      arr.take(top)
    rescue ArgumentError
      exit
    end
  end

  def gems_info(name)
    name.map do |gem|
      InfoGem.new(gem).call
    end
  end
end

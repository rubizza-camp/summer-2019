require 'yaml'
require 'table_print'
require_relative './gem_info.rb'

class GemScorer
  def call(options)
    list = load_gemlist(options[:file])
    gem_names = filter_by_name(list, options[:name])
    gems_array = get_gems_info(gem_names)
    gems_array.sort_by!(&:popularity).reverse!
    gems_array = take_top(gems_array, options[:top])
    tp gems_array, :name, { used_by: { display_name: 'used by' } },
       { watch: { display_name: 'Watched By' } },
       :star, :fork, { contrib: { display_name: 'Contributors' } },
       :issues
  end

  def load_gemlist(file)
    YAML.load_file(file)
  rescue Errno::ENOENT
    puts 'file must exist'
    exit
  end

  def filter_by_name(list, name)
    list['gems'].find_all { |g| g.match(name) }
  end

  def take_top(arr, top = nil)
    top ||= arr.size
    begin
      arr.take(top)
    rescue ArgumentError
      puts 'top must be positive'
      exit
    end
  end

  def get_gems_info(names)
    names.map do |gem|
      GemInfo.new(gem).call
    end
  end
end

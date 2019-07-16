require './libs/gems_finder.rb'
require 'bundler'
require 'yaml'
require 'optparse'
Bundler.require

show_gems = GemsFinder.new
OptionParser.new do |opts|
  opts.on('--file[=FILE]') do |file|
    show_gems.get_github_url(YAML.load_file(file))
  end

  opts.on('--name[=NAME]') do |name|
    name_array = []
    show_gems.array_of_gems.each do |gem_inf|
      name_array << gem_inf if gem_inf[0].include? name
    end
    show_gems.rewrite_final_array(name_array)
  end

  opts.on('--top[=TOP]', Integer) do |top|
    top_array = []
    (0..top - 1).each do |element|
      top_array << show_gems.array_of_gems[element] unless show_gems.array_of_gems[element].nil?
    end
    show_gems.rewrite_final_array(top_array)
  end
end.parse!
show_gems.put_into_console

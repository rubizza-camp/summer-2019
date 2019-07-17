require 'optparse'
require_relative 'table.rb'
require_relative 'gemlist.rb'
require_relative 'top_ruby_gems.rb'
require_relative 'file_interaction.rb'

(show_top(TopRubyGems.top_gems) if ARGV.empty?)
OptionParser.new do |options|
  options.on('-t', '--top NUMBER', Integer,
             'Top of Ruby gems from gems.yml file') do |max_num_gems|
    show_top(TopRubyGems.top_gems.first(max_num_gems))
  end

  options.on('-n', '--name NAME', String,
             'Shows all the gems from gems.yml, whose name contains the specified word') do |text|
    show_top(TopRubyGems.pick_names(text))
  end

  options.on('-f', '--file FILE', String,
             'Specify gems.yml containing a list of gem names') do |file|
    another_name_gem = Files.new.name_gem(file)
    make_another_gemlist = another_name_gem.map { |title| RubyGem.new(title) }
    show_top(TopRubyGems.sort_gems(make_another_gemlist))
  end

  options.on('-h', '--help',
             'Use this option for more info') do
    puts options
    exit
  end
end.parse!

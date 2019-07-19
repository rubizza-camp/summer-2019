require 'optparse'
require_relative 'show_top_table.rb'
require_relative 'gem_list.rb'
require_relative 'top_ruby_gems.rb'
require_relative 'gem_list_fetcher.rb'

ShowTopTable.new(TopRubyGems.top_gems).call if ARGV.empty?
OptionParser.new do |options|
  options.on('-t', '--top NUMBER', Integer,
             'Top of Ruby gems from gems.yml file') do |max_num_gems|
    ShowTopTable.new(TopRubyGems.top_gems.first(max_num_gems)).call
  end

  options.on('-n', '--name NAME', String,
             'Shows all the gems from gems.yml, whose name contains the specified word') do |text|
    ShowTopTable.new(TopRubyGems.pick_names(text)).call
  end

  options.on('-f', '--file FILE', String,
             'Specify gems.yml containing a list of gem names') do |file|
    another_name_gem = GemListFetcher.new.read_from_file(file)
    make_another_gemlist = another_name_gem.map { |title| RubyGem.new(title) }
    ShowTopTable.new(TopRubyGems.sort_gems(make_another_gemlist)).call
  end

  options.on('-h', '--help',
             'Use this option for more info') do
    puts options
    exit
  end
end.parse!

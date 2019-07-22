require 'yaml'
require 'gems'
require 'mechanize'
require 'httparty'
require 'terminal-table'
require 'pry'
require 'optparse'
require './files/terminal_table'
require './files/gems_get_params'
require './files/gems_loader'
require './files/url_loader'
require './files/gems_main'

if ARGV.empty?
  work_with_gems = WorkWithGems.new
  work_with_gems.start
  work_with_gems.terminal_table_builder
else
  OptionParser.new do |opts|
    opts.on('--file[=FILE]') do |file|
      work_with_gems = WorkWithGems.new
      work_with_gems.start(file)
      work_with_gems.terminal_table_builder
    end

    opts.on('--top[=NUM]', Integer) do |top|
      work_with_gems = WorkWithGems.new
      work_with_gems.start
      work_with_gems.terminal_table_builder(top)
    end

    opts.on('--name[=NAME]', String) do |name|
      gems_for_top_option = []
      work_with_gems = WorkWithGems.new
      a.start
      a.gems_for_term_table.each do |gem_inf|
        gems_for_top_option << gem_inf if gem_inf[first].include?(name)
      end
      TerminalTable.new(gems_for_top_option, gems_for_top_option.length)
    end
  end.parse!
end

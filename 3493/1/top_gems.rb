require 'yaml'
require 'json'
require 'terminal-table'
require_relative './models/gem_model.rb'
require_relative './functional/gem_manager.rb'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'gems'
require 'optparse'

# :reek:UtilityFunction:
def name_instruction(name_gems)
  gem_manager = Functions::GemManager.new
  gem_manager.parse_gem_info(name_gem: name_gems)
  gem_manager.print_table
end

# :reek:UtilityFunction:
def file_instruction(file_name)
  gem_manager = Functions::GemManager.new
  gem_manager.parse_gem_info(file_name: file_name)
  gem_manager.print_table
end

# :reek:UtilityFunction:
def top_instruction(top_count)
  gem_manager = Functions::GemManager.new
  gem_manager.parse_gem_info
  gem_manager.choose_top_gem(top_count)
  gem_manager.print_table
end

OptionParser.new do |parser|
  parser.on('-f', '--file=FILE') do |file|
    file_instruction(file)
  end
  parser.on('-n', '--name=NAME') do |name|
    name_instruction(name)
  end
  parser.on('-t', '--top=TOP') do |top|
    top_instruction(top.to_i)
  end
end.parse!

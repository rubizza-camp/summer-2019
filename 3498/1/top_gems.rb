require_relative './lib/load_gems.rb'
require_relative './lib/manager.rb'
require 'yaml'
require 'mechanize'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'
require 'optparse'

options = {}

OptionParser.new do |parser|
  parser.on('-t', '--top=NUMBER') do |number|
    options[:number] = number
  end
  parser.on('-n', '--name=NAME') do |name|
    options[:word] = name
  end
  parser.on('-f', '--file=FILE') do |file|
    options[:file_name] = file
  end
end.parse!

Manager.new(options).count_gems_rating

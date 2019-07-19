require 'yaml'
require 'json'
require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'optparse'
require 'psych'
require 'pry'
require 'terminal-table'
require_relative 'gems_fetch'
require_relative 'data_builder'
require_relative 'printer'

terminal_input = {}

OptionParser.new do |parser|
  parser.on('-t', '--top=NUMBER') do |top|
    terminal_input[:top] = top
  end
  parser.on('-n', '--name=NAME') do |name|
    terminal_input[:name] = name
  end
  parser.on('-f', '--file=FILE') do |file|
    terminal_input[:file] = file
  end
end.parse!

gems_fetch = GemsFetch.new(terminal_input[:file] || 'gems.yml')

data_builder = DataBuilder.new
data_builder.construct(gems_fetch.links, gems_fetch.names, terminal_input)

printer = Printer.new
puts printer.output(data_builder.header, data_builder.rows)

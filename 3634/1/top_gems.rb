require 'yaml'
require 'json'
require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'optparse'
require 'pry'
require 'terminal-table'
require_relative 'gems'
require_relative 'parser'
require_relative 'printer'

terminal_opts = {}

OptionParser.new do |parser|
  parser.on('-t', '--top=NUMBER') do |top|
    terminal_opts[:top] = top
  end
  parser.on('-n', '--name=NAME') do |name|
    terminal_opts[:name] = name
  end
  parser.on('-f', '--file=FILE') do |file|
    terminal_opts[:file_name] = file
  end
end.parse!

gems = Gems.new(terminal_opts[:file_name] ||= 'gems.yml')
parser = Parser.new
parser.scrap(gems.links, gems.names, terminal_opts)
printer = Printer.new
puts printer.output(parser.header, parser.rows)

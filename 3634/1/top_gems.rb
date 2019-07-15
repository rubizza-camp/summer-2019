require 'yaml'
require 'json'
require 'pry'
require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'terminal-table'
require_relative 'gems'
require_relative 'parser'
require_relative 'printer'

gems = Gems.new('gems.yml')
parser = Parser.new
parser.scrap(gems.links, gems.names)
printer = Printer.new
puts printer.output(parser.header, parser.rows)

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
require_relative 'user_terminal'

terminal = UserTerminal.new
terminal.run

gems_fetch = GemsFetch.new
gems_fetch.fetch(terminal.input[:file] || 'gems.yml')

data_builder = DataBuilder.new
data_builder.construct(gems_fetch.links, gems_fetch.names, terminal.input)

printer = Printer.new
puts printer.output(data_builder.header, data_builder.rows)

require 'octokit'
require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'dotenv'
require 'terminal-table'
require_relative 'io_stream.rb'
require_relative 'top_of_gems.rb'
require_relative 'api.rb'
require_relative 'html_reader.rb'
require_relative 'html_parser.rb'
require_relative 'gem.rb'
Dotenv.load
top_gems = GemsHandler.new(ENV['ACCESS_TOKEN'])
top_gems.call

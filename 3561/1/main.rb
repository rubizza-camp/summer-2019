require 'octokit'
require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'optparse'
require_relative 'api_parser.rb'
require_relative 'option_parser.rb'
require_relative 'html_parser.rb'
require_relative 'html_reader.rb'
require_relative 'file_reader.rb'
require_relative 'sorter.rb'
require_relative 'output.rb'
require_relative 'top_gems.rb'
require_relative 'gem.rb'

options = OptionRepositoty.options_for_gems
TopGems.new(options).run

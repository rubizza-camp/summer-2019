require 'yaml'
require 'json'
require 'pry'
require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'terminal-table'
require_relative 'gems'
require_relative 'parser'

gems = Gems.new('gems.yml')
parser = Parser.new(gems.links, gems.names)
p parser.data

# github_data = Parser.new(github_paths.uri)

# uri = github_paths.fetch('gems.yml')
# github_data.extraction(github_paths.paths)

# html = open(github_paths.fetch('gems.yml'))[:others][1]
#    document = Nokogiri::HTML(html)
#    document.css("a[class='social-count']")[0].text

# /network/dependents

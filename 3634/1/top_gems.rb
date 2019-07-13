require 'yaml'
require 'json'
require 'pry'
require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'terminal-table'
require_relative 'github_paths'


g = GitHubPaths.new
p g.fetch('gems.yml')


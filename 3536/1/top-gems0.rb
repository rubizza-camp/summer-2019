require 'yaml'
require 'net/http'
require 'uri'
require 'json'
require_relative 'github-parser'
require_relative 'params'

def print_data(gem,data)
  result = "#{gem} \s  \t| watched by #{data['watchers']} \t| #{data['stars']} stars \t| #{data['forks']} forks \t| #{data['contributors']} contributors \t| #{data['issues']} issues \t|"
  puts result
end

params_file
file_main

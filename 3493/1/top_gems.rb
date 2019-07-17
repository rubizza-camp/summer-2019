require 'yaml'
require 'json'
require 'terminal-table'
require_relative './models/gem_model.rb'
require_relative './object_managers/object_managers.rb'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'gems'
require 'optparse'

OptionParser.new do |parser|
  parser.on('-f', '--file=FILE') do |file|
    ObjectManagers::GemControl.call(file, nil, -1)
  end
  parser.on('-n', '--name=NAME') do |name|
    ObjectManagers::GemControl.call('gems.yaml', name, -1)
  end
  parser.on('-t', '--top=TOP') do |top|
    ObjectManagers::GemControl.call('gems.yaml', nil, top.to_i)
  end
end.parse!

require 'yaml'
require 'json'
require 'terminal-table'
require_relative './models/gem_model.rb'
require_relative './functional/gem_manager.rb'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'gems'
require 'optparse'

OptionParser.new do |parser|
  parser.on('-f', '--file=FILE') do |file|
    GemMethod::GemManager.call(file, nil, -1)
  end
  parser.on('-n', '--name=NAME') do |name|
    GemMethod::GemManager.call('gems.yaml', name, -1)
  end
  parser.on('-t', '--top=TOP') do |top|
    GemMethod::GemManager.call('gems.yaml', nil, top.to_i)
  end
end.parse!

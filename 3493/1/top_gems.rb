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
    gem_manager = GemMethod::GemManager.new(file, nil, -1)
    gem_manager.call
  end
  parser.on('-n', '--name=NAME') do |name|
    GemMethod::GemManager.call('gems.yaml', name, -1)
    # gem_manager = GemMethod::GemManager.new('gems.yaml', name, -1)
    # gem_manager.call
  end
  parser.on('-t', '--top=TOP') do |top|
    gem_manager = GemMethod::GemManager.new('gems.yaml', nil, top.to_i)
    gem_manager.call
  end
end.parse!

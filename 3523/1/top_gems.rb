# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require_relative 'linker'
require_relative 'gemrepoparser'
require_relative 'order'
require_relative 'yamlreader'

options = {}

OptionParser.new do |opts|
  opts.banner = 'options'

  opts.on('--top=NUM') do |num|
    options[:top] = num.to_i
  end

  opts.on('--name=NAME') do |name|
    options[:name] = name
  end

  opts.on('--file=PATH') do |path|
    options[:file] = YAML.load_file(path)['gems']
  end
end.parse!

yamlreader = YamlReader.new('gems.yaml').read
linker = Linker.new(yamlreader).find_links
gemrepoparser = GemRepoParser.new(linker).result_strings
order = Order.new(gemrepoparser)

if options.key? :top
  puts order.result_sort[0..options[:top] - 1]
elsif options.key? :name
  order.result_sort.each do |i|
    puts i if i.include? options[:name]
  end
elsif options.key? :file
  puts options[:file]
else
  puts order.result_sort
end

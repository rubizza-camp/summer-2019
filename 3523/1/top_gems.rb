# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require_relative 'linker'
require_relative 'githubinfo'
require_relative 'sorter'
require_relative 'filereader'

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
    options[:gems] = YAML.load_file(path)['gems']
  end
end.parse!

filereader = FileReader.new('gems.yaml')
linker = Linker.new(filereader.read)
githubinfo = GitHubInfo.new(linker.find_links)
sorter = Sorter.new(githubinfo.info)

if options.key? :top
  puts sorter.result_sort[0..options[:top] - 1]
elsif options.key? :name
  sorter.result_sort.each do |i|
    puts i if i.include? options[:name]
  end
elsif options.key? :gems
  puts options[:gems]
else
  puts sorter.result_sort
end

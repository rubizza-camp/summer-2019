# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require_relative 'githubinfo'
require_relative 'sorter'
require_relative 'filereader'

a = FileReader.new('gems.yaml')
b = GitHubInfo.new(a.find_links)
c = Sorter.new(b.info)

if ARGV.empty?
  puts c.result_sort
elsif ARGV.first == '--file'
  puts 'gems.yaml'
elsif ARGV.first.include? '--top'
  puts c.result_sort[0..ARGV[0].split('=').last.to_i - 1]
elsif ARGV.first.include? '--name'
  c.result_sort.each do |i|
    puts i if i.include? ARGV[0].split('=').last
  end
end

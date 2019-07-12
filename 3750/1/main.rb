require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative 'gem'

def read_file(array)
  File.open('/home/alexander/RubymineProjects/top_gems/gems.yaml', 'r') do |f|
    f.each_line do |line|
      next if line.chomp == 'gems:'
      array << Gemy.new(line.strip[2..-1])
      p array
    end
  end
end

gems = []
read_file(gems)

gems.each &:show_stats




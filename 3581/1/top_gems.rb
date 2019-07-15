require 'nokogiri'
require 'open-uri'
require 'rubygems'
require 'terminal-table'
require 'optparse'
require 'yaml'
require_relative 'parser.rb'
require_relative 'data_output.rb'

class Top
  def call_method
    top = DataOutput.new
    top.read_yml_file
    top.draw_table
  end
end

Top.new.call_method

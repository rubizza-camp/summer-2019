# frozen_string_literal: true

require 'optparse'
require_relative 'output'

options = {}

OptionParser.new do |parser|
  parser.on('-t', '--top=NUMBER') do |number|
    options[:number] = number
  end
  parser.on('-n', '--name=NAME') do |name|
    options[:word] = name
  end
  parser.on('-f', '--file=FILE') do |file|
    options[:file_name] = file
  end
end.parse!

Output.new(options).print_table

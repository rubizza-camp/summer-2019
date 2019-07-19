require_relative 'table.rb'
require 'optparse'

selector = {}
OptionParser.new do |opts|
  opts.on('--top=') { |top| selector[:top] = top.to_i }
  opts.on('--name=') { |name| selector[:name] = name }
  opts.on('--file=') { |file_name| selector[:file] = file_name }
end.parse!

Table.fetch_table_output(selector)

require_relative 'table.rb'
require 'optparse'
# :reek:NestedIterators
# :reek:TooManyStatements
class TerminalParser
  def self.do_terminal_parse
    selector = {}
    OptionParser.new do |opts|
      opts.on('--top=') { |top| selector[:top] = top.to_i }
      opts.on('--name=') { |name| selector[:name] = name }
      opts.on('--file=') { |file_name| selector[:file] = file_name }
    end.parse!
    selector
  end
end

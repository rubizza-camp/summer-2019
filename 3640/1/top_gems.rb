require_relative 'table.rb'
require_relative 'program_launch.rb'
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
    selector.size > 1 ? (puts 'invalid arguments entered') : ProgramLaunch.play_program(selector)
  end
end

TerminalParser.do_terminal_parse

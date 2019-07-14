require_relative 'table.rb'
require_relative 'program_launch.rb'
require 'optparse'

class TerminalParser
  def self.do_terminal_parse
    selector = {}
    OptionParser.new do |opts|
      opts.on('--top=') do |top|
        selector[:top] = top.to_i
      end

      opts.on('--name=') do |name|
        selector[:name] = name
      end

      opts.on('--file=') do |file_name|
        selector[:file] = file_name
      end
    end.parse!
    ProgramLaunch.play_program(selector)
  end
end

TerminalParser.do_terminal_parse

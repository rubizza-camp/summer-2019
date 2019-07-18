require './lib/stats_output.rb'
require 'optparse'
# Class for console parameters handling
class OptionsHandler
  attr_reader :final_stats, :file, :word, :top

  def initialize
    @file = ''
    @word = ''
    @top = ''
    check_options
  end

  private

  def check_options
    OptionParser.new do |opts|
      check_file(opts)
      check_name(opts)
      check_top(opts)
    end.parse!
    StatsOutput.new(@file, @word, @top).show_output
  end

  def check_file(option)
    option.on('--file[=FILE]') do |file|
      @file = file
    end
  end

  def check_name(option)
    option.on('--name[=NAME]') do |word|
      @word = word
    end
  end

  def check_top(option)
    option.on('--top[=TOP]', Integer) do |top|
      @top = top
    end
  end
end

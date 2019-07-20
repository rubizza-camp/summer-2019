require './lib/data_fetcher.rb'
require './lib/stats_output.rb'
require 'optparse'
# Class for console parameters handling
class OptionsHandler
  attr_reader :file, :word, :top

  def initialize
    @file = ''
    @word = ''
    @top = ''
  end

  def self.start_data_collecting
    new.start_data_collecting
  end

  def start_data_collecting
    OptionParser.new do |opts|
      check_file(opts)
      check_name_and_top(opts)
    end.parse!
    all_data = DataFetcher.collect_all_data(@file)
    StatsOutput.new(@word, @top).show_output(all_data)
  end

  private

  def check_file(option)
    option.on('--file[=FILE]') do |file|
      @file = file
    end
  end

  def check_name_and_top(option)
    option.on('--name[=NAME]') do |word|
      @word = word
    end
    option.on('--top[=TOP]', Integer) do |top|
      @top = top
    end
  end
end

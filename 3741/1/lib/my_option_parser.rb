require 'optparse'

class MyOptionParser
  AVAILABLE_OPT = %w[--top= --name= --file=].freeze

  def self.parse_options
    my_options_parser = MyOptionParser.new
    my_options_parser.parse_options
    my_options_parser.options
  end

  attr_reader :options

  def initialize
    @options = {}
  end

  def parse_options
    parser ||= OptionParser.new
    parse_top_option(parser)
    parse_name_option(parser)
    parse_file_option(parser)
    parser.parse!
  end

  def parse_top_option(parser)
    parser.on('--top=') { |value| @options[:top] = value.to_i }
  end

  def parse_name_option(parser)
    parser.on('--name=') { |value| @options[:name] = value }
  end

  def parse_file_option(parser)
    parser.on('--file=') { |value| @options[:file] = value }
  end
end

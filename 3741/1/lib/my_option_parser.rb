require 'optparse'

class MyOptionParser
  attr_reader :options

  def initialize
    @options = {}
    parser = OptionParser.new
    parser.on('--top=', '--top') { |value| @options[:top] = value.to_i }
    parser.on('--name=', '--name') { |value| @options[:name] = value }
    parser.on('--file=', '--file') { |value| @options[:file] = value }
    parser.parse!
  end
end

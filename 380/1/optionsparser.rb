
require 'optparse'
# include method for parsing options
module OptionsParser
  # :reek:NestedIterators, :reek:TooManyStatements, :reek:UtilityFunction
  def check_attributes
    options = {}
    parsing = OptionParser.new do |parser|
      parse_file(parser, options)
      parse_count(parser, options)
      parse_name(parser, options)
    end
    parsing.parse!
    options
  end

  def parse_file(parser, options)
    parser.on('-t', '--top [top]', Integer, 'Enter count of gems in top:') do |top|
      options[:count] = top if top
    end
  end

  def parse_count(parser, options)
    parser.on('-f', '--file [file]', String, 'Enter your yml file:') do |file|
      options[:file] = file if file
    end
  end

  def parse_name(parser, options)
    parser.on('-n', '--name [STRING]', String, 'Enter gem you need:') do |name|
      options[:name] = name if name
    end
  end
end

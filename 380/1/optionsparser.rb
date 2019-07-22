
require 'optparse'
# include method for parsing options
module OptionsParser
  # :reek:NestedIterators, :reek:TooManyStatements, :reek:UtilityFunction
  # rubocop:disable Metrics/MethodLength
  def options
    options = {}
    OptionParser.new do |parser|
      parse_file(parser)
      parse_count(parser)
      parse_name(parser)
    end.parse!
    options
  end

  def parse_file(parser)
    parse.on('-t', '--top [top]', Integer, 'Enter count of gems in top:') do |top|
      options[:count] = top if top
    end
  end

  def parse_count(parser)
    parse.on('-f', '--file [file]', String, 'Enter your yml file:') do |file|
      options[:file] = file if file
    end
  end

  def parse_name(parser)
    parse.on('-n', '--name [STRING]', String, 'Enter gem you need:') do |name|
      options[:name] = name if name
    end
  end
  # rubocop:enable Metrics/MethodLength
end

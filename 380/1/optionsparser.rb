
require 'optparse'
# include method for parsing options
module OptionsParser
  # :reek:NestedIterators, :reek:TooManyStatements, :reek:UtilityFunction
  # rubocop:disable Metrics/MethodLength
  def options
    options = {}
    OptionParser.new do |parse|
      parse.on('-t', '--top [top]', Integer, 'Enter count of gems in top:') do |top|
        options[:count] = top if top
      end
      parse.on('-f', '--file [file]', String, 'Enter your yml file:') do |file|
        options[:file] = file if file
      end
      parse.on('-n', '--name [STRING]', String, 'Enter gem you need:') do |name|
        options[:name] = name if name
      end
    end.parse!
    options
  end
  # rubocop:enable Metrics/MethodLength
end

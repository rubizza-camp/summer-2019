require 'optparse'

# :reek:TooManyStatements
# :reek:NestedIterators
# rubocop:disable Metrics/MethodLength
class Parser
  attr_reader :flags, :args

  def initialize(file_string, args)
    @flags = {}
    @flags[:file_name] = file_string.to_s
    @args = args
  end

  def parse
    opt_parser = OptionParser.new do |options|
      options.banner = 'Usage: top_gems.rb [options]'

      options.on('-t', '--top NUMBER', 'Displays NUMBER of top gems') do |amount|
        flags[:number] = amount
      end

      options.on('-n', '--name ANYWORD', 'Shows only gems with ANYWORD in name') do |gem_name|
        flags[:word] = gem_name
      end

      options.on('-f', '--file FILE', 'Enable desired FILE') do |file|
        flags[:file_name] = file
      end

      options.on('-h', '--help', 'Shows this information') do
        puts options
        abort
      end
    end
    opt_parser.parse!
    flags
  end
end
# rubocop:enable Metrics/MethodLength

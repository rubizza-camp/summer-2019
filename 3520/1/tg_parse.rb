require 'optparse'

# rubocop:disable Metrics/MethodLength
# This class smells of :reek:TooManyStatements and
class TGParse
  # This methos smells of :reek:NestedIterators and :reek:UnusedParameters
  def self.parse(args)
    options = {}
    opts = OptionParser.new do |opt|
      opt.banner = 'Usage: top_gems.rb [options]'

      opt.on('-top', '--top=TOP', 'Show toplist of gems.') do |top|
        # Here we can call our function for top with number TOP
        options[:top] = top
      end

      opt.on('-n', '--name=NAME', 'Show list of gems with name is.') do |name|
        # Same for list of gems which contains Name
        options[:name] = name
      end

      opt.on('-f', '--file', 'Show path for gems.yml.') do |file|
        # Same for list of gems which contains Name
        options[:file] = file
      end

      opt.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    opts.parse!(args)
    options
  end
end
# rubocop:enable Metrics/MethodLength

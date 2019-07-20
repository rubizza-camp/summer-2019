require 'optparse'

# rubocop:disable Metrics/MethodLength
# This class smells of :reek:TooManyStatements and
class TGParse
  # This methos smells of :reek:NestedIterators and :reek:UnusedParameters
  def self.parse(args)
    options = {}
    opts = OptionParser.new do |opt|
      opt.banner = 'Usage: top_gems.rb [options]'

      opt.on('-t', '--top=TOP', Integer, 'Show toplist of gems.') do |top|
        options[:top] = top
      end

      opt.on('-n', '--name=NAME',String, 'Show list of gems with name is.') do |name|
        options[:name] = name
      end

      opt.on('-f', '--file=FILE', String, 'Show path for gems.yml.') do |file|
        options[:file] = file
      end

      opt.on('-d', '--delete', 'Delete all temp files') do
        options[:delete] = true
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

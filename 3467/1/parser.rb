# rubocop:disable Lint/UnneededCopDisableDirective
# rubocop:disable Metrics/MethodLength
require 'optparse'

# :reek:TooManyStatements
# :reek:NestedIterators
class CommandLineParser
  def self.parse(args)
    options = {}
    opts_p = OptionParser.new do |opts|
      opts.banner = 'Usage: top_gems.rb'

      opts.on('-tTOP',
              '--top=INTEGER',
              Integer,
              'Shows the number of gems according to the rating') do |ttt|
        options[:top] = ttt
      end

      opts.on('-nNAME',
              '--name=REGEX',
              'Displays Gems rating which name includes the given regular expression') do |nnn|
        options[:name] = nnn
      end

      opts.on('-fFILE',
              '--file=Path_to_Filename.yml',
              /([a-zA-Z0-9\s_\\.\-\(\):])+.yml$/,
              'Path to the .yml file containing the list of gem names') do |fff|
        options[:file] = fff[0]
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
      end
    end

    begin
      opts_p.parse(args)
    rescue StandardError => err
      puts "Exception encountered: #{err}"
      opts_p.parse %w[--help]
      exit 1
    end

    options
  end
end
# rubocop:enable Metrics/MethodLength
# rubocop:enable Lint/UnneededCopDisableDirective

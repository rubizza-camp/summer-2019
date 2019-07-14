# rubocop:disable Metrics/MethodLength, Lint/ShadowingOuterLocalVariable
require_relative 'repo'
require_relative 'pages'
require 'optparse'
# :reek:NestedIterators :reek:TooManyStatements
class Cli
  def self.parse(args)
    options = {}
    opts = OptionParser.new do |opts|
      opts.on('-t', '--top NUMBER', 'Number of gems from top-1') do |number|
        options[:number] = number
      end

      opts.on('-n', '--name NAME', 'Set of gems with NAME string presense') do |name|
        options[:name] = name
      end

      opts.on('-f', '--file FILE', 'Path to file with gems list') do |file|
        options[:file] = file
      end
    end
    opts.parse(args)
    options
  end
end
# rubocop:enable Metrics/MethodLength, Lint/ShadowingOuterLocalVariable

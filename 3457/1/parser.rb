require 'optparse'
# Class CommandLineParser is responsible for parsing
class CommandLineParser
  def self.parse(args)
    options = {}
    opts = OptionParser.new do |option|
      option.banner = 'Usage: top_gems.rb'
    end
    except(opts, args)
    options
  end

  def self.top(option)
    option.on('-TOP', '--top=INTEGER > 0', /[1-9]+/,
              'Shows the number of gems according
               to the rating') do |top|
      options[:top] = top
    end
  end

  def self.name(option)
    option.on('-NAME', '--name=WORD', 'Displays all the Gems according to the rating in
              the name of which includes the given word') do |name|
      options[:name] = name
    end
  end

  def self.file(option)
    option.on('-FILE',
              '--file=Path_to_Filename.yml', /([a-zA-Z0-9\s_\\.\-\(\):])+.yml$/,
              'Path to the .yml file containing the list of gem names') do |file|
      options[:file] = file
    end
  end

  def self.except(opts, args)
    opts.parse(args)
  rescue StandardError
    puts "Exception encountered: #{StandardError}"
    opts.parse %w[--help]
    exit 1
  end
end

# This class sets comands for terminal

require 'optparse'

class OptionParserSetter
  attr_reader :commands

  # :reek:FeatureEnvy
  def set_commands
    default_commands
    OptionParser.new do |opts|
      opts.on('--top[=OPTIONAL]', Integer, 'Show top')
      opts.on('--name[=OPTIONAL]', String, 'Filter by name')
      opts.on('--file[=OPTIONAL]', String, 'Path')
    end.parse!(into: commands)
  end

  private

  def default_commands
    @commands = {
      file: 'gems.yml',
      name: ''
    }
  end
end

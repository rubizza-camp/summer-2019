require 'optparse'

class TGParse
  def self.parse
    @options = {}
    parser_commands
    @options
  end

  def self.parser_commands
    OptionParser.new do |opt|
      opt.on('-tTOP', '--top=TOP', Integer, 'Show toplist of gems.')
      opt.on('-nNAME', '--name=NAME', String, 'Show list of gems with name is.')
      opt.on('-fFILE', '--file=FILE', String, 'Show path for gems.yml.')
    end.parse!(into: @options)
  end
end

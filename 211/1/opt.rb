require 'optparse'

class OptparseScript
  def self.parse
    options = {}
    opt_parser = OptionParser.new do |opts|
      opts.on('--top[=NUM]', Integer)
      opts.on('--name[=NAME]', String)
      opts.on('--file[=FILE]', String)
    end
    # begin
    #   opt_parser.parse!(into: options)
    # rescue OptionParser::InvalidArgument => e
    #   puts "#{e}. 'top' must be a number"
    #   exit 1
    # end
    opt_parser.parse!
    options
  end
end



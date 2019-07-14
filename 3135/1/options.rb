require 'optparse'

def parse_options
  option_parser = OptionParser.new do |opts|
    opts.on '--top[=NUM]', Integer
    opts.on '--name[=NAME]'
    opts.on '--file[=FILE]'
  end

  options = {}
  option_parser.parse!(into: options)
  puts options
  options
end
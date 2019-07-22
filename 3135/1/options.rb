require 'optparse'

# :reek:TooManyStatements, :reek:UtilityFunction
def parse_options
  option_parser = OptionParser.new do |opts|
    opts.on '--file[=FILE]'
    opts.on '--name[=NAME]'
    opts.on '--top[=NUM]', Integer
  end

  options = { top: nil, name: nil, file: 'gem_list.yml' }
  option_parser.parse!(into: options)
  options
end

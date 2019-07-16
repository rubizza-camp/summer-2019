require 'optparse'

class OptparseScript
  def self.parse
    options = { name: '\w+', file: 'gem_list.yml' }
    opt_parser = OptionParser.new do |opts|
      opts.on('--top[=NUM]', Integer)
      opts.on('--name[=NAME]', String)
      opts.on('--file[=FILE]', String)
    end
    opt_parser.parse!(into: options)
    options
  end
end

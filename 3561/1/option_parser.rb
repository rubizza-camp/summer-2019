require 'optparse'

#:reek:TooManyStatements
class OptionRepositoty
  def self.options_for_gems
    options = {}
    OptionParser.new do |opts|
      init_parser(opts, options)
    end.parse!
    options
  end

  def self.init_parser(opt, options)
    opt.on('-t', '--top = t', Integer) { |item| options[:top] = item }
    opt.on('-n', '--name = n', String) { |item| options[:name] = item }
    opt.on('-f', '--file = f', String) { |item| options[:file] = item }
  end
end

require 'optparse'

class CommandLineParser
  def self.parse(args)
    options = {}
    opts_p = OptionParser.new do |opts|
      init_parser(opts, options)
    end
    raise_error(opts_p, args)

    options
  end

  def self.raise_error(opts_p, args)
    opts_p.parse(args)
  rescue StandardError => err
    puts "Exception encountered: #{err}"
    opts_p.parse %w[--help]
    exit 1
  end

  def self.init_parser(opts, options)
    opt_on_t(opts, options)
    opt_on_n(opts, options)
    opt_on_f(opts, options)
    opts.on('-h', '--help', 'Prints this help') { puts opts }
  end

  def self.opt_on_t(opts, options)
    opts.on('-tTOP', '--top=INTEGER', Integer, 'Number of gems according to the rating') do |ttt|
      options[:top] = ttt
    end
  end

  def self.opt_on_n(opts, options)
    opts.on('-nNAME', '--name=REGEX', 'Gem name includes the given regular expression') do |nnn|
      options[:name] = nnn
    end
  end

  def self.opt_on_f(opts, options)
    opts.on('-fFILE', '--file=File.yml', /([a-zA-Z0-9\s_\\.\-\(\):])+.yml$/, '.yml file') do |fff|
      options[:file] = fff[0]
    end
  end
end

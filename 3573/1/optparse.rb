module OptParser
  DEFAULT_GEMS_FILE = 'ruby_gems.yaml'.freeze

  # :reek:ToManyStatements
  def parse_options
    options = {}
    optparse = OptionParser.new do |opts|
      parse_opts(opts, options)
    end
    optparse.parse!
    options[:file] ||= DEFAULT_GEMS_FILE
    options
  end

  def parse_opts(opts, options)
    opts.on('-f', '--file [=OPTIONAL]', String, 'Enter file to open.') do |file|
      options[:file] = file
    end
    opts.on('-n', '--name [=OPTIONAL]', String, 'Enter gem name') do |name|
      options[:sort_name] = name
    end
    opts.on('-t', '--top [=OPTIONAL]', Integer, 'Enter number to filter top of gems') do |top|
      options[:top] = top
    end
  end
end

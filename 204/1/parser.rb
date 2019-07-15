module Parser
  DEFAULT_GEM_LIST_FILE = 'gems.yaml'.freeze


  # :reek:TooManyStatements
  def parse_options
    options = {}
    optparse = OptionParser.new do |opts|
      option_file(opts, options)
      option_name(opts, options)
      option_top(opts, options)
    end
    optparse.parse!
    options[:file] ||= DEFAULT_GEM_LIST_FILE
    options
  end

  # :reek:DataClump
  # :reek:NilCheck
  # :reek:UtilityFunction
  def option_file(opts, options)
    opts.on('-f', '--file [STRING]', String, 'Enter the config file to open.') do |file|
      options[:file] = file
    end
  end

  # :reek:DataClump
  # :reek:NilCheck
  def option_name(opts, options)
    opts.on('-n', '--name [STRING]', String, 'Enter name to filter gems by name') do |name|
      raise 'You enter invalid option. Option :name can be only string or number' if name.nil?

      options[:name_sort] = name
    end
  end

  # :reek:DataClump
  # :reek:NilCheck
  def option_top(opts, options)
    opts.on('-t', '--top [INTEGER]', Integer, 'Enter number to filter top of gems') do |top|
      raise 'You enter invalid option.Option :top can be only integer number' if top.nil?

      options[:top] = top
    end
  end
end

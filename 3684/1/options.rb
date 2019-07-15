require 'optparse'

class Parser
  attr_reader :flags

  def initialize(file_string)
    @flags = {}
    @flags[:file_name] = file_string.to_s
  end

  def add_word_search_and_top_options(options)
    options.on('-t', '--top NUMBER', 'Displays NUMBER of top gems') do |num|
      flags[:number] = num
    end

    options.on('-n', '--name ANYWORD', 'Shows only gems with ANYWORD in name') do |word|
      flags[:word] = word
    end
  end

  def add_file_and_help_options(options)
    options.on('-f', '--file FILE', 'Enable desired FILE') { |file| flags[:file_name] = file }

    options.on('-h', '--help', 'Shows this information') do
      puts options
      abort
    end
  end

  def parse
    opt_parser = OptionParser.new do |options|
      add_word_search_and_top_options(options)
      add_file_and_help_options(options)
    end
    opt_parser.parse!
    flags
  end
end

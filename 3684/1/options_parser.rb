require 'optparse'

class OptionsParser
  def initialize(file_string)
    @flags = { file_name: file_string.to_s }
  end

  def parse
    opt_parser = OptionParser.new do |options|
      add_word_search_and_top_options(options)
      add_file_and_help_options(options)
    end
    opt_parser.parse!
    @flags
  end

  private

  def add_word_search_and_top_options(options)
    options.on('--top=NUMBER', 'Displays NUMBER of top gems') do |num|
      @flags[:number] = num
    end

    options.on('--name=ANYWORD', 'Shows only gems with ANYWORD in name') do |word|
      @flags[:word] = word
    end
  end

  def add_file_and_help_options(options)
    options.on('--file=FILE', 'Enable desired FILE') do |file|
      @flags[:file_name] = file
    end

    options.on('-h', '--help', 'Shows this information') do
      puts options
      abort
    end
  end
end

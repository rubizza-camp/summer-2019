require 'optparse'

module Scanner
  class Shell
    ARG_VALUE_REGEXPS = {
      top: /\d+/,
      name: /[A-z0-9]+/,
      file: %r{(\/?[A-z0-9])+\.yml$}
    }.freeze

    def initialize
      @args = {}
      args_handling
    end

    def scan
      @args.each do |name, value|
        abort("Fill arg \"#{name}\" value.") if value.empty?
        abort("Invalid arg \"#{name}\" value.") unless value.match(ARG_VALUE_REGEXPS[name])
      end
      @args
    end

    private

    def args_handling
      OptionParser.new do |option|
        define_avail_args(option)
      end.parse!
    rescue OptionParser::InvalidOption => err
      abort("You used #{err.message}. Try again without it.")
    end

    # reek is a reason of these all
    def define_avail_args(option)
      define_top_arg(option)
      define_name_arg(option)
      define_file_arg(option)
    end

    def define_top_arg(option)
      option.on('--top TOP') { |opt| @args[:top] = opt }
    end

    def define_name_arg(option)
      option.on('--name NAME') { |opt| @args[:name] = opt }
    end

    def define_file_arg(option)
      option.on('--file FILE') { |opt| @args[:file] = opt }
    end
  end
end

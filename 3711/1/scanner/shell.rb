module Scanner
  class Shell
    ARG_REGEXPS = [
      /--top=\d+/,
      /^--name=[A-z0-9]+/,
      %r{^--file=(\/?[A-z0-9])+\.yml$}
    ]
    def scan(args)
      filter_args(args).each_with_object({}) do |arg, obj|
        flag, value = arg.split('=')
        arg_name = flag.tr('--', '')
        obj[arg_name] = value
      end
    end

    private

    def filter_args(args)
      args.select do |arg|
        arg if ARG_REGEXPS.any? { |arg_regexp| arg.match(arg_regexp) }
      end
    end
  end
end

module OptionValidation
  def self.check_option(options)
    return 'base' if options.empty?

    case options.keys.first.to_s
    when 'name'
      'by_name'
    when 'file'
      'g_file'
    when 'top'
      'toplist'
    end
  end
end

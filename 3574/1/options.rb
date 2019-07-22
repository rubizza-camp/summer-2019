require 'optparse'

class Options
  def call(from_file)
    options_parser(from_file)
  end

  private

  def number(from_file, opt_number)
    opt_number.on('--top NUMBER') { |opt| from_file[:top] = opt }
  end

  def gem_name(from_file, opt_gem_name)
    opt_gem_name.on('--name GEM_NAME') { |opt| from_file[:gem_name] = opt }
  end

  def file(from_file, opt_file)
    opt_file.on('--file FILE') { |opt| from_file[:file_name] = opt }
  end

  def options_parser(from_file)
    OptionParser.new do |opts|
      number(from_file, opts)
      gem_name(from_file, opts)
      file(from_file, opts)
    end.parse!
  end
end

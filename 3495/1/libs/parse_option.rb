# This class parse option parameters
# :reek:NestedIterators
# :reek:TooManyStatements
class OptionParse
  def self.parse
    @options ||= {}
    OptionParser.new do |opts|
      opts.on('--file=', '') { |value| @options[:file_path] = value }
      opts.on('--top=', '') { |value| @options[:top_gems] = value }
      opts.on('--name=', '') { |value| @options[:name_of_gem] = value }
    end.parse!
    @options
  end
end

# I don't think there is a problem there with block nesting and utility function(cause it's module)
# and with many statements(that is what it should do, IMHO), so
# :reek:NestedIterators and :reek:UtilityFunction and :reek:TooManyStatements
module OptionsScraper
  def parse
    options = {}
    OptionParser.new do |opt|
      opt.on('--top TOP') { |option| options[:top] = option }
      opt.on('--name NAME') { |option| options[:name] = option }
      opt.on('--file FILE') { |option| options[:file] = option }
    end.parse!
    options
  end
end

require_relative './optparse'
require_relative './scorer_gem.rb'

begin
  options = OptparseScript.parse
rescue OptionParser::InvalidArgument => e
  puts "#{e}. 'top' must be a number"
  exit 1
end
ScorerGem.new.call(options)

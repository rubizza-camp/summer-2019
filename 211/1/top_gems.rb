require_relative './optparse_script.rb'
require_relative './gem_scorer.rb'

begin
  options = OptparseScript.parse
rescue OptionParser::InvalidArgument => e
  puts "#{e}. 'top' must be a number"
  exit 1
end
GemScorer.new.call(options)

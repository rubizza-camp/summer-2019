require './lib/TopGems.rb'
require './lib/TGParse.rb'



# options = TGParse.parse(ARGV)
# top_gem = TopGems.new
# top_gem.run(options)
# TopGems.new.run(options)

TopGems.new.run(TGParse.parse(ARGV))
# p "top is #{options[:top]}" if options.keys.include?(:top)
# # top_gem.gem_toplist(options[:top]) if options.has_key?('top'.to_sym)
#
#
# p "name is #{options[:name]}" if options.has_key?('name'.to_sym)
#
#
# p "name is #{options[:file]}" if options.has_key?('file'.to_sym)
# RubyGemsLink.new.file if options.has_key?('file'.to_sym)

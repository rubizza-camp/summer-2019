# rubocop:disable Style/PreferredHashMethods
require './tg_parse.rb'

options = TGParse.parse(ARGV)

p "top is #{options[:top]}" if options.has_key?('top'.to_sym)
p "name is #{options[:name]}" if options.has_key?('name'.to_sym)
# rubocop:enable Style/PreferredHashMethods

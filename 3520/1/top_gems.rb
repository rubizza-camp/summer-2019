# rubocop:disable Style/PreferredHashMethods
require './tg_parse.rb'
require './gem_scrapper.rb'

options = TGParse.parse(ARGV)

p "top is #{options[:top]}" if options.has_key?('top'.to_sym)
p "name is #{options[:name]}" if options.has_key?('name'.to_sym)
# rubocop:enable Style/PreferredHashMethods

scrap = GemScrapper.new('https://rubygems.org/gems/sinatra/')

p scrap.used_by
p scrap.watch
p scrap.star
p scrap.fork
p scrap.contributors
p scrap.issues

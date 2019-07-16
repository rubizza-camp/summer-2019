# rubocop:disable Style/PreferredHashMethods
require './tg_parse.rb'
require './gem_scrapper.rb'
require './rubygems_links'

options = TGParse.parse(ARGV)

p "top is #{options[:top]}" if options.has_key?('top'.to_sym)
p "name is #{options[:name]}" if options.has_key?('name'.to_sym)
# rubocop:enable Style/PreferredHashMethods

# add some functional to get links from rubygems by gemname in gems.yaml
rg = RubyGemsLink.new
links = rg.yaml_links
scrap = GemScrapper.new
links.each do |link|
  p link
  scrap.get_page(link)
  sleep 0.5
  scrap.repo_info
  # p "##{scrap.gem_name}  used_by #{scrap.used_by} watch #{scrap.watch} #{scrap.star} stars #{scrap.fork} forks #{scrap.contributors} contributors #{scrap.issues}"
end

# rubocop:disable Style/PreferredHashMethods
require './repo_scrapper.rb'
require './rubygems_links'
require './tg_parse.rb'

options = TGParse.parse(ARGV)

p "top is #{options[:top]}" if options.has_key?('top'.to_sym)
p "name is #{options[:name]}" if options.has_key?('name'.to_sym)
# rubocop:enable Style/PreferredHashMethods

# add some functional to get links from rubygems by gemname in gems.yaml
rg = RubyGemsLink.new
links = rg.yaml_links
scrap = RepoScrapper.new
links.each do |link|
  p link
  scrap.get_repo_page(link)
  scrap.repo_info_parse
end

# rubocop:disable Style/PreferredHashMethods
require './repo_scrapper.rb'
require './rubygems_links'
require './tg_parse.rb'
require './output_table.rb'
require 'yaml'

options = TGParse.parse(ARGV)

p "top is #{options[:top]}" if options.has_key?('top'.to_sym)
p "name is #{options[:name]}" if options.has_key?('name'.to_sym)
# rubocop:enable Style/PreferredHashMethods

def backup_file_create(file)
  File.write("./YAML/#{file[:name]}.yml", file.to_yaml) unless File.exist?("./YAML/#{file[:name]}.yml")
  p 'backup_file created'
end

def backup_file_load(file)
  # return YAML.load text
  YAML.load File.read "./YAML/#{file}.yml"
end

test_hash = {}
# add some functional to get links from rubygems by gemname in gems.yaml
rg = RubyGemsLink.new
ot = OutPutTable.new
links = rg.yaml_links
scrap = RepoScrapper.new
info = {}
links.each do |link|
  p link
  scrap.get_repo_page(link)
  info = scrap.repo_info_parse
  # File.write("./YAML/#{info[:name]}.yml", info.to_yaml) unless File.exist?('./YAML/#{info[:name]}.yml')
  if Dir.empty?('YAML')
    backup_file_create(info)
    ot.add_value(info)
  else
    'try load backup_file'
    ot.add_value backup_file_load(info[:name])
  end
  # p "#{info[:name].to_sym} name?"
  # test_hash.store(info[:name], info)
end

puts ot.show_table

# puts test_hash

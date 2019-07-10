require 'yaml'
require 'httparty'
require 'nokogiri'

class GemPopularity
  include HTTParty
  base_uri 'https://github.com/'
  attr_accessor :used, :name, :watch, :star, :fork

  def initialize(gem_name)
    @name = gem_name
    page = HTTParty.get("https://github.com/#{gem_name}/#{gem_name}")
    doc = Nokogiri::HTML(page.body)
    @watch = doc.css('a.social-count')[0].text.strip
    @star = doc.css('a.social-count')[1].text.strip
    @fork = doc.css('a.social-count')[2].text.strip
  end
end

gems_array = YAML.safe_load(File.read('gem_list.yml'))
gems_array['gems'].each do |gem_n|
  # puts gem_n.class
  gem_name = GemPopularity.new(gem_n)
  puts "#{gem_name.name} | watched by #{gem_name.watch} | #{gem_name.star} stars | #{gem_name.fork} forks "
end
# sinatra = GemPopularity.new('sinatra')

# puts "#{sinatra.name} | watched by #{sinatra.watch} | #{sinatra.star} stars | #{sinatra.fork} forks "

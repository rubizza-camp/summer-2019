require 'yaml'
require 'httparty'
require 'nokogiri'
require 'optparse'
require 'json'

class GemPopularity
  include HTTParty
  base_uri 'https://api.github.com/repos/'
  attr_accessor :used, :name, :watch, :star, :fork, :contrib, :issues, :used_by

  def initialize(gem_name)
    @name = gem_name
    page = HTTParty.get("https://api.github.com/repos/#{gem_name}/#{gem_name}")
    page  = JSON.parse(page.body)
    @watch = page["subscribers_count"]
    @star = page["stargazers_count"]
    @fork = page["forks"]
  end

  def contrib
    page = HTTParty.get("https://api.github.com/repos/#{self.name}/#{self.name}/contributors")
    page  = JSON.parse(page.body)
    contrib = page.count
  end

  def issues
    page = HTTParty.get("https://api.github.com/repos/#{self.name}/#{self.name}/issues")
    page  = JSON.parse(page.body)
    issues = page.count
  end

  def used_by
    page = HTTParty.get("https://github.com/#{self.name}/#{self.name}/network/dependents")
    doc = Nokogiri::HTML(page.body)
    used_by = doc.css('a.selected')[3].text.match(/([0-9]+),[0-9]+/).to_s.gsub(/,/,'').to_i
  end
end

# sinatra = GemPopularity.new('sinatra')

# puts "#{sinatra.name} | watched by #{sinatra.watch} | #{sinatra.star} stars | #{sinatra.fork} forks "

class OptparseScript
  def self.parse(args)
    options = {}
      opt_parser = OptionParser.new do |opts|
  
        opts.on('--top[=NUM]') do |num|
          p options[:top] = num.to_i
        end
        opts.on('--name[=NAME]') do |name|
          p options[:name] = name
        end
        opts.on('--file[=FILE]') do |file|
          p options[:file] = file
        end
      end 
  
      opt_parser.parse!(args)
      options
  end

end

options = OptparseScript.parse(ARGV)
pp options

def load_gemlist(file=nil)
  file ||= 'gem_list.yml'
  @gems = YAML.safe_load(File.read(file))
end

def find_match(gems, name=nil)
  name ||= '\w+'
  @gems_array = @gems['gems'].find_all {|g| g.match(name)}
end

def take_top(top=nil)
  top ||= @gems_array.size
  @gems_array  = @gems_array.take(top)
end

load_gemlist(options[:file])
find_match(@gems, options[:name])
take_top(options[:top])

gems_done = []

@gems_array.each do |gem_n|
  gem_name = GemPopularity.new(gem_n)
  gems_done << gem_name
end


gems_done.sort_by! {|gem| gem.name}
# gems_printed = gems_done.find_all {|g| g.name.match(options[:name])}
gems_done.each do |gem_name|
  puts "#{gem_name.name}| used by #{gem_name.used_by}  | watched by #{gem_name.watch} | #{gem_name.star} stars | #{gem_name.fork} forks | #{gem_name.contrib} contributors "
end


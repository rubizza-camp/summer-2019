require 'yaml'
require 'httparty'
require 'nokogiri'
require 'optparse'

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


# options[:file] ? load_gemlist(options[:file]) : load_gemlist()

def find_match(gems, name=nil)
  name ||= '\w+'
  @gems_array = @gems['gems'].find_all {|g| g.match(name)}
end


# options[:name] ? find_match(@gems, options[:name]) :find_match(@gems, '\w+') 

def take_top(top=nil)
  top ||= @gems_array.size
  @gems_array  = @gems_array.take(top)
end

# options[:top] ? take_top(options[:top]) : take_top()

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
  puts "#{gem_name.name} | watched by #{gem_name.watch} | #{gem_name.star} stars | #{gem_name.fork} forks "
end


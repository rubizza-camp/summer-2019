require 'yaml'
require 'httparty'
require 'nokogiri'
require 'optparse'
require 'json'
require 'table_print'

class GemPopularity
  include HTTParty
  # base_uri 'https://api.github.com/repos/'
  attr_accessor  :name, :watch, :star, :fork, :contrib, :issues_op, :issues_closed, :used_by, :issues

  def initialize(gem_name)
    @name = gem_name
    rubygems_page = HTTParty.get("https://rubygems.org/api/v1/gems/#{gem_name}")
    @github_link = JSON.parse(rubygems_page.body)['source_code_uri']
    # @api_github_link = @sgithub_link.gsub(/github.com/, "api.github.com/repos" )
    # response = HTTParty.get(@api_github_link)
    # page  = JSON.parse(response.body)
    # @watch = page['subscribers_count']
    # @star = page['stargazers_count']
    # @fork = page['forks']
    page = HTTParty.get(@github_link)
    @doc = Nokogiri::HTML(page.body)
    @watch = @doc.css('.social-count')[0].text.tr('^0-9', '').to_i
    @star = @doc.css('.social-count')[1].text.tr('^0-9', '').to_i
    @fork = @doc.css('.social-count')[2].text.tr('^0-9', '').to_i
  end

  def contrib
    @contrib = @doc.css('ul.numbers-summary li span')[3].text.tr('^0-9', '').to_i
  end

  def issues
    page = HTTParty.get("#{@github_link}/issues")
    doc = Nokogiri::HTML(page.body)
    issues = doc.css('div.states')
    @issues_op = issues.css('a')[0].text.tr('^0-9', '').to_i
    @issues_closed = issues.css('a')[1].text.tr('^0-9', '').to_i
    @issues = "Closed issues / opened issues = #{@issues_closed/@issues_op}"
  end

  def used_by
    page = HTTParty.get("#{@github_link}/network/dependents")
    doc = Nokogiri::HTML(page.body)
    used_by = doc.css('a.selected')[3].text.tr('^0-9', '').to_i
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


gems_done.sort_by! {|gem| gem.watch}

gems_done.each do |gem_name|
  puts gem_name.issues
  puts "#{gem_name.name}| used by #{gem_name.used_by}  | watched by #{gem_name.watch} | #{gem_name.star} stars | #{gem_name.fork} forks | #{gem_name.contrib} contributors "
end

tp gems_done,  :name,
               {:used_by => {:display_name  => 'used by'}},
               {:watch => {:display_name  => 'Watched By'}},
               :star,
               :fork,
               {:contrib => {:display_name  => 'Contributors'}},
               {:issues_op => {:display_name  => 'Opend issues'}},
               {:issues_closed => {:display_name  => 'Closed issues'}}



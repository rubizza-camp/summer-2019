# require 'yaml'
require 'httparty'
require 'nokogiri'
require 'optparse'
require 'json'
require 'table_print'
require_relative './github_page.rb'

class GemPopularity
  include HTTParty
  # base_uri 'https://api.github.com/repos/'
  attr_accessor :name, :watch, :star, :fork, :contrib, :used_by, :issues, :popularity

  def initialize(gem_name)
    @name = gem_name
    GithubPage.new(gem_name)
    file = File.open("#{gem_name}.html", 'r')

    doc = Nokogiri::HTML(file)
    @watch = doc.css('.social-count')[0].text.tr('^0-9', '').to_i
    @star = doc.css('.social-count')[1].text.tr('^0-9', '').to_i
    @fork = doc.css('.social-count')[2].text.tr('^0-9', '').to_i
    @issues = doc.css('span.Counter')[0].text.tr('^0-9', '').to_i
    @used_by = doc.css('a.selected')[3].text.tr('^0-9', '').to_i
    file.close

    main_file = File.open("#{gem_name}_main.html", 'r')
    main_doc = Nokogiri::HTML(main_file)
    @contrib = main_doc.css('span.text-emphasized')[3].text.tr('^0-9', '').to_i
    main_file.close
  end
end

class OptparseScript
  def self.parse(args)
    options = {}
    opt_parser = OptionParser.new do |opts|
      opts.on('--top[=NUM]', Integer) do |num|
        options[:top] = num.to_i
      end
      opts.on('--name[=NAME]', String) do |name|
        options[:name] = name
      end
      opts.on('--file[=FILE]', String) do |file|
        options[:file] = file
      end
    end

    opt_parser.parse!(args)
    options
  end
end

options = OptparseScript.parse(ARGV)

def load_gemlist(file = nil)
  file ||= 'gem_list.yml'
  @gems = YAML.safe_load(File.read(file))
end

def find_match(_gems, name = nil)
  name ||= '\w+'
  @gem_names = @gems['gems'].find_all { |g| g.match(name) }
end

def take_top(arr, top = nil)
  top ||= arr.size
  arr.take(top)
end

load_gemlist(options[:file])
find_match(@gems, options[:name])

gems_array = []

@gem_names.each do |gem_n|
  gem_inst = GemPopularity.new(gem_n)
  gems_array << gem_inst
end

criteria = %i[watch star fork contrib used_by issues]
weights = { used_by: 10, watch: 4, star: 8, fork: 6, contrib: 1, issues: 2 }

hash_g = {}

gems_array.each do |g|
  h = {}
  hash_g[g.name] = h
  criteria.each do |c|
    h[c] = g.send(c)
  end
end

# working on normalization
# def normalise(xcur, xmin, xmax, dif0 = 0, dif1 = 1)
#   xrange = xmax - xmin
#   drange = dif1 - dif0
#   (dif0 + (xcur - xmin) * (drange.to_f / xrange)).round(2)
# end

# ashn = {}
# hash_g.each do |_k, vh|
#   vh.each do |k1, v1|
#     ashn[k1] ||= []
#     ashn[k1] << v1
#   end
# end

# hash_g.each do |_k, vh|
#   vh.each do |k1, v1|
#     vh[k1] = normalise(v1, ashn[k1].min, ashn[k1].max)
#   end
# end

hash_g.each do |g, cr|
  cr.each do |k, v|
    cr[k] = v * weights[k]
  end
  hash_g[g] = cr.values.reduce(:+).round(2)
end

gems_array.each do |g|
  g.popularity = hash_g[g.name]
end

gems_array.sort_by!(&:popularity).reverse!
gems_array = take_top(gems_array, 2)
tp gems_array, :name,
   { used_by: { display_name: 'used by' } },
   { watch: { display_name: 'Watched By' } },
   :star,
   :fork,
   { contrib: { display_name: 'Contributors' } },
   :issues

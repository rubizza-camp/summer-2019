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
    GithubPage.new(gem_name).write_files
    @file = File.open("#{gem_name}.html", 'r')
    @doc = Nokogiri::HTML(@file)
    @main_file = File.open("#{gem_name}_main.html", 'r')
    @main_doc = Nokogiri::HTML(@main_file)
  end

  def find_int(css)
    css.text.tr('^0-9', '').to_i
  end

  def set_criteria
    @watch = find_int(@doc.css('.social-count')[0])
    @star = find_int(@doc.css('.social-count')[1])
    @fork = find_int(@doc.css('.social-count')[2])
    @issues = find_int(@doc.css('span.Counter')[0])
    @used_by = find_int(@doc.css('a.selected')[3])
    @file.close
    @contrib = find_int(@main_doc.css('span.text-emphasized')[3])
    @main_file.close
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
    begin
      opt_parser.parse!(args)
    rescue OptionParser::InvalidArgument => e
      puts "#{e}. 'top' must be a number"
      exit 1
    end
    # opt_parser.parse!(args)
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
  gem_inst.set_criteria
  gems_array << gem_inst
end

# working on normalization
criteria = %i[watch star fork contrib used_by issues]
weights = { used_by: 10, watch: 4, star: 8, fork: 6, contrib: 1, issues: 2 }

def normalise(xcur, xmin, xmax, dif0 = 1, dif1 = 10)
  xrange = xmax - xmin
  drange = dif1 - dif0
  (dif0 + (xcur - xmin) * (drange.to_f / xrange)).round(2)
end

hash_g = {}

# hsh_tr = {}
# criteria.each do |cr|
#   arr = []
#   gems_array.each do |gemin|
#     arr << gemin.send(cr)
#   end
#   hsh_tr[cr] = arr
# end
# puts hsh_tr

gems_array.each do |g|
  h = {}
  hash_g[g.name] = h
  criteria.each do |c|
    h[c] = g.send(c)
  end
end

hash_transp = {}
hash_g.each do |_k, vh|
  vh.each do |k1, v1|
    hash_transp[k1] ||= []
    hash_transp[k1] << v1
  end
end

hash_g.each do |_k, vh|
  vh.each do |k1, v1|
    vh[k1] = normalise(v1, hash_transp[k1].min, hash_transp[k1].max)
  end
end

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
gems_array = take_top(gems_array, options[:top])
tp gems_array, :name,
   { used_by: { display_name: 'used by' } },
   { watch: { display_name: 'Watched By' } },
   :star,
   :fork,
   { contrib: { display_name: 'Contributors' } },
   :issues,
   :popularity

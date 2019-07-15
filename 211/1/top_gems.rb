require 'yaml'
require 'httparty'
require 'json'
require 'table_print'
require_relative './opt.rb'
require_relative './gem_info.rb'
require_relative './cli.rb'

options = OptparseScript.parse
@gems_array = GemScorer::Cli.new.call(options)
# def load_gemlist(file = nil)
#   file ||= 'gem_list.yml'
#   begin
#     @gems = YAML.safe_load(File.read(file))
#   rescue Errno::ENOENT
#     puts 'file must exist'
#     exit
#   end
# end

# def find_match(_gems, name = nil)
#   name ||= '\w+'
#   @gem_names = @gems['gems'].find_all { |g| g.match(name) }
# end

# def take_top(arr, top = nil)
#   top ||= arr.size
#   begin
#     arr.take(top)
#   rescue ArgumentError
#     puts 'top must be positive'
#     exit
#   end
# end




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
#   @gems_array.each do |gemin|
#     arr << gemin.send(cr)
#   end
#   hsh_tr[cr] = arr
# end
# puts hsh_tr

@gems_array.each do |g|
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

@gems_array.each do |g|
  g.popularity = hash_g[g.name]
end

@gems_array.sort_by!(&:popularity).reverse!
# @gems_array = take_top(@gems_array, options[:top])
tp @gems_array, :name,
   { used_by: { display_name: 'used by' } },
   { watch: { display_name: 'Watched By' } },
   :star,
   :fork,
   { contrib: { display_name: 'Contributors' } },
   :issues,
   :popularity

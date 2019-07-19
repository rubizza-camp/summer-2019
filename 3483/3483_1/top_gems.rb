require_relative 'top_gem'
require_relative 'gem_file_loader'
require_relative 'gem_statistics'

loader = GemfileLoader.new('gems_list.yaml')
best = TopGem.new

(0...loader.gem_list.size).each do |i|
  loader.gem_list[i] = GemStatistics.new(loader.gem_list[i]).fetch_gem_info
end

best.call(loader.gem_list)

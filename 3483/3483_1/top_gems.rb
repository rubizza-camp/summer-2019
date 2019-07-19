require_relative 'the_best_gem'
require_relative 'gem_file_loader'
require_relative 'gem_statistics'

main_array = []

list_gems = GemfileLoader.new('gems_list.yaml')
best = TheBestGem.new

(0...list_gems.gem_list.size).each do |i|
  main_array << GemStatistics.new(list_gems.gem_list[i]).gem_stats
end

best.call(main_array)

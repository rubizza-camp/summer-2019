require_relative 'top_gem'
require_relative 'gem_file_loader'
require_relative 'gem_statistics'

main_array = []

loder = GemfileLoader.new('gems_list.yaml')
best = TopGem.new

(0...loder.gem_list.size).map do |i|
  main_array << GemStatistics.new(loder.gem_list[i]).gem_stats
end

best.call(main_array)

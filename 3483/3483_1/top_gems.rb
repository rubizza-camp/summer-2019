require_relative 'the_best_gem'
require_relative 'gem_file_list_open'
require_relative 'git_hub_repository_parser'

main_array = []

info = GitHubRepositoryParser.new
list_gems = GemFileListOpen.new('gems_list.yaml')
best = TheBestGem.new

(0...list_gems.fetch_gems_list.size).each do |i|
  info.gem_name = list_gems.fetch_gems_list[i]
  main_array << info.fetch_gem_info
end

best.call(main_array)

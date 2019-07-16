require_relative 'algorim'
require_relative 'gems_reader'
require_relative 'parser'

main_array = []

info = GemInfo.new
list_gems = GemFileListOpen.new
best = TheBestGem.new

(0...list_gems.yaml_size).each do |i|
  main_array << info.get_array(list_gems.inject(i))
end

best.get_top(main_array)

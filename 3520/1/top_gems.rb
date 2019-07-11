# Обязательное задание со звездочкой:
#
# Мы можем передать дополнительные аргументы:
#
#     Параметр --top, показывает количество гемов согласно рейтинга:
#
# ruby top_gems.rb --top=2
#
#     Параметр --name, выводит все Gems согласно рейтинга в имя которых входит заданное слово:
#
# ruby top_gems.rb --name=active
#
#     Параметр --file, который является путем к yml файлу, содержащему список имен гемов:
#
# ruby top_gems.rb --file=gems.yml

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: top_gems.rb [options]"

  opts.on("-top", "Show toplist of gems.") do |v|
    options[:toplist] = v
  end
end.parse!

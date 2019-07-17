require_relative 'sorted_pages'
require_relative 'repo_info_loader'
require_relative 'page_printer'
require 'optparse'

options = {}

OptionParser.new do |parser|
  parser.on('-t', '--top=NUMBER') do |number|
    options[:number] = number
  end
  parser.on('-n', '--name=NAME') do |name|
    options[:name] = name
  end
  parser.on('-f', '--file=FILE') do |file|
    options[:file] = file
  end
end.parse!

doc = YAML.load_file(options[:file] || 'gems.yml')

repo = RepoInfoLoader.new
repo.call(doc)

page = SortedPages.new
page.call(repo.list)

represent = PagePrinter.new(page.rows)

if options[:number]
  represent.call(options[:number].to_i)
elsif options[:name]
  represent.call(options[:name].to_s)
else
  represent.call
end

p repo.list

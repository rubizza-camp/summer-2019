# frozen_string_literal: true

require_relative 'links'
require_relative 'sorter'
require_relative 'reader'

links = FileReader.new('gems.yaml')
pars = GitHubInfo.new(links.find_links)
sort = Sorter.new(pars.info)

if ARGV.empty?
  puts sort.result_sort
elsif ARGV.first == '--file'
  puts 'gems.yaml'
elsif ARGV.first.include? '--top'
  puts sort.result_sort[0..ARGV[0].split('=').last.to_i - 1]
elsif ARGV.first.include? '--name'
  sort.result_sort.each do |temp|
    puts temp if temp.include? ARGV[0].split('=').last
  end
end

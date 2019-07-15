# frozen_string_literal: true

require_relative 'gets_value'
require_relative 'sorting_value'
require_relative 'gets_link'

gets_value = GetLink.new('gems.yaml')
pars = GitValue.new(gets_value.gets_links)
sorting = Sorting.new(pars.gets_value)

if ARGV.empty?
  puts sorting.result_sorting
elsif ARGV.first == '--file'
  puts 'gems.yaml'
elsif ARGV.first.include? '--top'
  puts sorting.result_sorting[0..ARGV[0].split('=').last.to_i - 1]
elsif ARGV.first.include? '--name'
  sorting .result_sorting.each do |temp|
    puts temp if temp.include? ARGV[0].split('=').last
  end
end

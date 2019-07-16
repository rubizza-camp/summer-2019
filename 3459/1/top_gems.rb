# frozen_string_literal: true

require_relative 'gitvalue'
require_relative 'sorting'
require_relative 'link'

reception_value = Link.new('gems.yaml')
pars = GitValue.new(reception_value.reception_link)
sorting = Sorting.new(pars.reception_value)

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

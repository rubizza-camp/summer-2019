require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'terminal-table'
require 'mechanize'
require 'yaml'
require_relative 'gemy'
require_relative 'score'
require_relative 'statistics'
require_relative 'statistic_presenter'
require_relative 'gem_fetcher'
require_relative 'link'
require_relative 'average'

options = {
  file_name:   nil,
  top_number:  nil,
  name:        nil
}

OptionParser.new do |parser|
  parser.on('--file=file_name') do |file_name|
    options[:file_name] = file_name
    puts "Path to directory of gems list is:\n" + Dir.pwd + '/gems.yaml'
    puts "file contents:\n"
    system('cat', Dir.pwd + '/gems.yaml')
  end
  parser.on('--top=number') do |number|
    options[:top_number] = number.to_i
  end
  parser.on('--name=gem_name') do |gem_name|
    options[:name] = gem_name
  end
end.parse!

exit if !options[:file_name].nil? && options[:top_number].nil? && options[:name].nil?

gems = GemFetcher.read_file_of_gems

gems.each(&:scrap_stats)

average_stats = Average.calculate_average_stats(gems)
gems.each { |gem| gem.scrap_overall_score(average_stats) }

gems.sort_by! { |gem| -gem.overall_score }

options[:top_number] = gems.size if options[:top_number].nil?
options[:name] = '' if options[:name].nil?

statistics = StatisticPresenter.new(gems)
statistics.show_gems_statistics(options[:top_number], options[:name])

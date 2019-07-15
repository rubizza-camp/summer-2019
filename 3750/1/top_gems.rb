require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'terminal-table'
require_relative 'gemy'
require_relative 'score'
require_relative 'statistics'
require_relative 'statistic_presenter'
require_relative 'gem_fetcher'

gems = []

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

GemFetcher.fill_array_of_gems(gems)

statistic = Statistics.new(gems)
statistic.load_stats

scores = Score.new(gems)
scores.calculate_scores

gems.sort! { |a_gem, b_gem| b_gem.overall_score <=> a_gem.overall_score }

options[:top_number] = gems.size if options[:top_number].nil?
options[:name] = '' if options[:name].nil?

statistics = StatisticPresenter.new(gems)
statistics.show_gems_statistics(options[:top_number], options[:name])

require './lib/data_collector.rb'
require './lib/data_parser.rb'
require 'open-uri'
# Class for fetching stats about gems
class DataFetcher
  attr_reader :list_of_urls, :stats

  def initialize(list_of_urls)
    @list_of_urls = list_of_urls
    @stats = []
  end

  def collect_all_data
    list_of_urls.each do |gems|
      stats << DataParser.new(gems[1]).only_stats.insert(0, gems[0])
    end
    DataCollector.new(stats).sort_stats
  end
end

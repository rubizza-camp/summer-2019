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
      gem_url = gems[1]
      parsed_html = Nokogiri::HTML(URI.parse(gem_url).open)
      stats << DataParser.new(parsed_html, gem_url).only_stats.insert(0, gems[0])
    end
    DataCollector.new(stats).sort_stats
  end
end

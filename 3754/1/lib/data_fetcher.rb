require './lib/github_links_collector.rb'
require './lib/data_parser.rb'
require './lib/sorter.rb'
require 'open-uri'
# Class for fetching stats about gems
class DataFetcher
  attr_reader :github_urls_list, :data

  def initialize
    @github_urls_list = {}
    @data = []
  end

  def self.collect_all_data(gems_list)
    new.collect_all_data(gems_list)
  end

  def collect_all_data(gems_list)
    @github_urls_list = GithubLinksCollector.take_urls(gems_list)
    @data = DataParser.collect_data(@github_urls_list)
    Sorter.sort_data(@data)
  end
end

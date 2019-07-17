require_relative 'gem_one.rb'

class AllGemsFetcher
  def self.fetch_all_gems(names)
    fetcher = new(names)
    fetcher.fetch_all_gems(names)
    fetcher.gems
  end

  attr_reader :names
  attr_reader :gems

  def initialize(names)
    @names = names
  end

  def fetch_all_gems(names)
    @gems = Scraper.fetch_gem_parameters(names)
  end
end

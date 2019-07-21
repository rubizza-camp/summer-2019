require_relative 'gem_resource.rb'

class AllGemsFetcher
  def self.fetch_all_gems(names)
    fetcher = new(names)
    fetcher.gems
  end

  attr_reader :names

  def initialize(names)
    @names = names
  end

  def gems
    Scraper.fetch_gem_parameters(names)
  end
end

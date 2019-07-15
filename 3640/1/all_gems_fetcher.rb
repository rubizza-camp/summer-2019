require_relative 'gem_one.rb'

# Class AllGems
class AllGemsFetcher
  def self.fetch_all_gems(names)
    fetcher = new(names)
    fetcher.fetch_all_gems
    fetcher.gems
  end

  attr_reader :names
  attr_reader :gems

  def initialize(names)
    @names = names
  end

  def fetch_all_gems
    @gems = names.map do |name_gem|
      GemOne.new(name_gem)
    end
  end
end

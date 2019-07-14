require_relative 'geme.rb'

# Class AllGems
class AllGemsFetcher
  def self.get_all_gems(names)
    fetcher = new(names)
    fetcher.get_all_gems
    fetcher.gems
  end

  attr_reader :names
  attr_reader :gems

  def initialize(names)
    @names = names
  end

  def get_all_gems
    @gems = names.map do |name_gem|
      Geme.new(name_gem)
    end
  end
end

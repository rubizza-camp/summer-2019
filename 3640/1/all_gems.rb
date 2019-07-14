require_relative 'geme.rb'

# Class AllGems
class AllGemsFetcher
  def self.all_gems_get(names)
    fetcher = new(names)
    fetcher.all_gems_get
    fetcher.gems
  end

  attr_reader :names
  attr_reader :gems

  def initialize(names)
    @names = names
  end

  def all_gems_get
    @gems = names.map do |name_gem|
      Geme.new(name_gem)
    end
  end
end

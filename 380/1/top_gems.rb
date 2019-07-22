require_relative 'gemlist'
require_relative 'toptable'
require_relative 'optionsparser'

# rubizza is no surrender!
class TopGems
  include OptionsParser

  # :reek:FeatureEnvy:
  def run
    selected = options
    gems_with_statistics = GemList.new(selected[:file], selected[:name]).statistics
    TopTable.new(gems_with_statistics, selected[:count]).show
  end
end

TopGems.new.run

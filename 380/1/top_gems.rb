require_relative 'gemlist'
require_relative 'toptable'
require_relative 'optionsparser'
require 'optparse'

# rubizza is no surrender!
class TopGems
  include OptionsParser

  # :reek:FeatureEnvy:
  def run
    options = check_attributes
    gems_with_statistics = GemList.new(options[:file], options[:name]).statistics
    TopTable.new(gems_with_statistics, options[:count]).show
  end
end

TopGems.new.run

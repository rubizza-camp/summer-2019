require 'pry'
require_relative 'gemlist'
require_relative 'toptable'
require_relative 'optionsparser'

# rubizza is no surrender!
class TopGems
  include OptionsParser

  # :reek:FeatureEnvy:
  def run
    selected = options
    gem_list = GemList.new(selected[:file], selected[:name]).with_information
    TopTable.new(gem_list, selected[:count]).show
  end
end

TopGems.new.run

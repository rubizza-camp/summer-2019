require_relative 'gemlist'
require_relative 'toptable'
require_relative 'optionsparser'
require 'terminal-table'
require 'optparse'
require 'nokogiri'
require 'octokit'
require 'yaml'
require 'gems'

# rubizza is no surrender!
class TopGems
  # :reek:FeatureEnvy:
  def run
    options = OptionsParser.new.check_attributes
    gems_with_statistics = GemList.new(options[:file], options[:name]).statistics
    TopTable.new(gems_with_statistics, options[:count]).show
  end
end

TopGems.new.run

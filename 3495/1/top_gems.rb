# Main class

require_relative './libs/gem_url_loader'
require_relative './libs/stats_loader'
require_relative './libs/gem_stats'
require_relative './libs/table_printer'
require_relative './libs/option_parse'
require_relative './libs/gem_list_loader'
require 'yaml'
require 'optparse'
require 'open-uri'
require 'bundler'
Bundler.require

class TopGems
  attr_reader :gems_arr, :parameters, :gems

  def init_gems_array
    @gems = []
    @parameters = OptionParse.call
    @gems_arr = GemListLoader.call
    parameters_load
  end

  def parameters_load
    parameters[:file] ? gems_arr.call(parameters[:file]) : gems_arr.call
    parameters[:name] ? make_with_custom_name : make_without_custom_name
  end

  def make_without_custom_name
    gems_arr.gems_arr.each do |gem_name|
      gem_stats = StatsLoader.new(gem_url_load(gem_name).url)
      gem = GemStats.call(gem_name, gem_stats.stats)
      @gems << gem
    end
    print_table
  end

  def print_table
    if parameters[:top]
      TablePrinter.new(@gems, parameters[:top]).output_info
    else
      TablePrinter.new(@gems).output_info
    end
  end

  def make_with_custom_name
    gems_arr.gems_arr.each do |gem_name|
      if gem_name.include? parameters[:name].to_s
        gem = GemStats.call(gem_name, StatsLoader.new(gem_url_load(gem_name).url).stats)
        @gems << gem
      end; next; end; print_table
  end

  def gem_url_load(gem_name)
    GemUrlLoader.call(gem_name)
  end
end

TopGems.new.init_gems_array

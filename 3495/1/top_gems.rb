require_relative './libs/get_gem_url'
require_relative './libs/get_params'
require_relative './libs/gem'
require_relative './libs/print_table'
require_relative './libs/parse_option'
require_relative './libs/load_gem_list'
require 'yaml'
require 'optparse'
require 'open-uri'
require 'bundler'
Bundler.require
# Main class
class TopGems
  attr_reader :gems_arr
  attr_reader :parameters
  attr_reader :gems

  def main
    @gems = []
    @parameters = OptionParse.new.parse
    @gems_arr = GemListLoader.new
    parameters_get
  end

  def parameters_get
    @parameters[:file] ? @gems_arr.call(@parameters[:file]) : @gems_arr.call
    @parameters[:name] ? make_with_custom_name : make_without_custom_name
  end

  def make_without_custom_name
    @gems_arr.gems_arr.each do |gem_name|
      gem_params = ParamsGetter.new(gem_url_get(gem_name).url)
      gem = MyGem.new(gem_name, gem_params.params)
      @gems << gem
    end
    print_table
  end

  def print_table
    if @parameters[:top]
      TablePrinter.new(@gems, @parameters[:top]).output_info
    else
      TablePrinter.new(@gems).output_info
    end
  end

  def make_with_custom_name
    @gems_arr.gems_arr.each do |gem_name|
      if gem_name.include? @parameters[:name].to_s
        gem = MyGem.new(gem_name, ParamsGetter.new(gem_url_get(gem_name).url).params)
        @gems << gem
      end; next; end; print_table
  end

  def gem_url_get(gem_name)
    GemUrlGetter.new(gem_name)
  end
end

TopGems.new.main

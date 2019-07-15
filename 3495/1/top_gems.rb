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
# :reek:DuplicateMethodCall
# :reek:InstanceVariableAssumption
# :reek:TooManyStatements
class TopGems
  attr_reader :gems_arr
  attr_reader :parameters
  attr_reader :gems

  def main
    @gems = []
    @parameters = OptionParse.parse
    @gems_arr = GemListLoader.new
    @parameters[:file_path] ? @gems_arr.call(@parameters[:file_path]) : @gems_arr.call
    @parameters[:name_of_gem] ? make_with_custom_name : make_without_custom_name
  end

  def make_without_custom_name
    @gems_arr.gems_arr.each do |gem_name|
      puts gem_name + ' - IN PROGRESS'
      gem_url = GemUrlGetter.new(gem_name)
      gem_params = ParamsGetter.new(gem_url.gem_url)
      gem = MyGem.new(gem_name, gem_params.params)
      @gems << gem
    end
    print_table
  end

  def print_table
    if @parameters[:top_gems]
      TablePrinter.new(@gems, @parameters[:top_gems]).output_info
    else
      TablePrinter.new(@gems).output_info
    end
  end

  def make_with_custom_name
    @gems_arr.gems_arr.each do |gem_name|
      if gem_name.include? @parameters[:name_of_gem].to_s
        puts gem_name + ' - IN PROGRESS'
        gem_url = GemUrlGetter.new(gem_name)
        gem_params = ParamsGetter.new(gem_url.gem_url)
        gem = MyGem.new(gem_name, gem_params.params)
        @gems << gem
      end; next; end; print_for_custom_name
  end

  def print_for_custom_name
    if @parameters[:top_gems]
      TablePrinter.new(@gems, @parameters[:top_gems]).output_info
    else
      TablePrinter.new(@gems).output_info
    end
  end
end

TopGems.new.main

require './libs/get_gem_url'
require './libs/get_params'
require './libs/gem'
require './libs/print_table'
require './libs/load_gem_list'
require 'yaml'
require 'optparse'
require 'open-uri'
require 'bundler'
Bundler.require
# Main class
#:reek:TooManyStatements:
#:reek:UtilityFunction:
class TopGems
  def main
    gems_arr = GemListLoader.new
    gems = []
    gems_arr.gems_arr.each do |gem_name|
      gem_url = GemUrlGetter.new(gem_name)
      gem_url.gem_url_with_source_code_uri
      gem_params = ParamsGetter.new(gem_url.gem_url)
      gem = MyGem.new(gem_name, *gem_params.params)
      gems << gem
    end
    TablePrinter.new(gems).output_info
  end
end

TopGems.new.main

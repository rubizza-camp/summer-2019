require './array_names_gems_creator.rb'
require './gem_info_fetcher.rb'
require './rating_creator.rb'
require './table_output.rb'
require './options_creator.rb'

# class for main task: start project
class TopGems
  def start_top_gems
    hash_options = OptionsCreator.new.hash_options
    array_name_gems = ArrayNamesGemsCreator.new.array_names_of_gems(hash_options)
    array_of_all_gems = create_array_with_all_information_about_gems(array_name_gems)
    array_of_all_gems = RatingCreator.new.array_of_rating_gems(array_of_all_gems)
    TableOutput.new.table_output(array_of_all_gems, hash_options[:top])
  end

  private

  def create_array_with_all_information_about_gems(array_name_gems)
    array_name_gems.each_with_object([]) do |name_gem, array_of_all_gems|
      hash_with_info_about_gem = GemInfoFetcher.new(name_gem).information_about_gem
      array_of_all_gems << hash_with_info_about_gem if hash_with_info_about_gem
    end
  end
end

TopGems.new.start_top_gems

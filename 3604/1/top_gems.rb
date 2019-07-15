require 'terminal-table'
require './data_initializer.rb'
require './gem_info_fetcher.rb'
require './create_rating.rb'

# class for main task: start project, get array of names and get arguments
# return table with all information
class TopGems
  ARR_FOR_TABLE = ['used by', ' watched by', ' stars', ' forks', ' contributors', ' issues'].freeze

  def initialize
    @array_gems = []
  end

  def start_top_gems
    initialize_object.hash_arguments
    create_array_with_all_information_about_gems
    add_rating_in_array_with_all_information
    table_output(@array_gems)
  end

  def create_array_with_all_information_about_gems
    array_name_gems.size.times do |iter|
      name_gem = array_name_gems[iter]
      information = GemInfoFetcher.new(name_gem).information_about_gem
      @array_gems << information if information != []
    end
  end

  def add_rating_in_array_with_all_information
    @array_gems = CreateRating.new(@array_gems).rating_of_gems
  end

  def table_output(array_gems)
    table = Terminal::Table.new
    table.style = { border_top: false, border_bottom: false }
    how_many_names_need_to_display?.to_i.times do |iter|
      table.add_row transformation_into_a_nice_view(array_gems[iter])
    end
    puts table
  end

  private

  def transformation_into_a_nice_view(array)
    1.upto(6) do |iter|
      array[iter] += ARR_FOR_TABLE[iter - 1]
    end
    array
  end

  def how_many_names_need_to_display?
    number_top_gems = hash_arguments[:top]
    count_gems = @array_gems.size
    if number_top_gems && number_top_gems.to_i < count_gems
      number_top_gems
    else
      count_gems
    end
  end

  def hash_arguments
    @hash_arguments ||= initialize_object.hash_argv
  end

  def array_name_gems
    @array_name_gems ||= initialize_object.array_names_of_gems
  end

  def initialize_object
    @initialize_object ||= DataInitializer.new
  end
end

TopGems.new.start_top_gems

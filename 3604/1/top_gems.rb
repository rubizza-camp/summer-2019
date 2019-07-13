require 'terminal-table'
require './data_initializer.rb'
require './get_information_about_gem.rb'
require './create_rating.rb'

# class for main task: start project, get array of names and get arguments
# return table with all information
class TopGems
  def initialize
    @array_gems = []
    @temp_arr = ['', ' used by', ' watched by', ' stars', ' forks', ' contributors', ' issues']
  end

  def start_top_gems
    getting_parameters_and_array_names_gems
    create_array_with_all_information_about_gems
    add_rating_in_array_with_all_information
    table_output(@array_gems)
  end

  def getting_parameters_and_array_names_gems
    initialize_object.getting_parameters
    initialize_object.open_file_with_names_of_gems
    flags_parameters
    array_name_gems
  end

  def create_array_with_all_information_about_gems
    array_name_gems.size.times do |iter|
      name_gem = array_name_gems[iter]
      information = GetInformationAboutGem.new(name_gem).information_about_gem
      @array_gems << information if information
    end
  end

  def add_rating_in_array_with_all_information
    @array_gems = CreateRating.new(@array_gems).create_rating
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
      array[iter] += @temp_arr[iter]
    end
    array
  end

  def how_many_names_need_to_display?
    number_top_gems = flags_parameters[:top]
    count_gems = @array_gems.size
    if number_top_gems && number_top_gems.to_i < count_gems
      number_top_gems
    else
      count_gems
    end
  end

  def flags_parameters
    @flags_parameters ||= initialize_object.hash_argv
  end

  def array_name_gems
    @array_name_gems ||= initialize_object.array_name_gems
  end

  def initialize_object
    @initialize_object ||= DataInitializer.new
  end
end

TopGems.new.start_top_gems

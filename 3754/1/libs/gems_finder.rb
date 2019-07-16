require 'open-uri'
require './libs/sorting.rb'
require './libs/check_url.rb'
require './libs/take_data.rb'
# class to find all gems according to list of gems
class GemsFinder
  attr_reader :array_of_gems, :gems_data

  def initialize
    @array_of_gems = []
    @gems_data = []
  end

  def take_data(gem_name, github_url)
    @gems_data << TakeData.new(github_url).collecting_all_data.insert(0, gem_name)
  end

  def get_github_url(gems_from_file)
    gems_from_file['gems'].each do |gem_name|
      info = Gems.info gem_name
      next unless (checked_url = CheckURL.new(info['homepage_uri'],
                                              info['source_code_uri']).check_url)

      take_data(gem_name, checked_url)
    end
    @array_of_gems = Sorting.new(@gems_data).sort
  end

  def rewrite_final_array(array)
    @array_of_gems = array
  end

  def put_into_console
    table = Terminal::Table.new headings: ['Gem', 'Used by', 'Watched by', 'Stars',
                                           'Forks', 'Contributors', 'Issues'], rows: @array_of_gems
    puts table
  end
end

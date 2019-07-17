require_relative 'gemhandler'
require_relative 'apihandler'

class UserCommunicator
  attr_reader :rows

  def initialize
    @rows = []
    @gem_list = []
  end

  def make_top
    @gem_list.sort_by! { |word| word[:rate] }
    @gem_list.each do |gem|
      gem.delete(:rate)
    end
  end

  def load_arguments
    ARGV.each do |argument|
      top_check(argument) if argument.include?('top')
      @gem_list = name_handler(argument) if argument.include?('name')
      make_top
      update_row
    end
  end

  def top_check(argument)
    end_index = argument[/[0-9]+/].to_i - 1
    @gem_list = @gem_list[0..end_index]
  end

  def update_row
    @rows = []
    @gem_list.each do |gem|
      @rows << gem.values
    end
  end

  def find_list(file)
    file['gems'].each do |gem_name|
      gem = GemsApiHandler.new(gem_name)
      next unless gem.find_github_link

      gem_handling = GemHandler.new(gem)
      @gem_list << gem_handling.data_about_gem
    end
  end

  def name_handler(argument)
    name_of_gem = argument.gsub('--name=', '')
    @gem_list.each_with_object([]) do |gem, gem_list|
      gem_list << gem if gem[:name].include?(name_of_gem)
    end
  end
end

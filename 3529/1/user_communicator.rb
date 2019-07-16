require_relative 'gemhandler'
require_relative 'apihandler'

class UserCommunicator
  attr_reader :rows

  def initialize
    @rows = []
    @gem_list = []
    ARGV.each do |argument|
      @file_name = argument.gsub('--file=', '') if argument.include?('file')
    end
    @file = YAML.safe_load(File.read(@file_name))
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
      name_handler(argument) if argument.include?('name')
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

  def find_list
    @file['gems'].each do |gem_name|
      gem = GemsApiHandler.new(gem_name)
      next unless gem.find_github

      gemh = GemHandler.new(gem.gem_github, gem_name)
      add_to_list gemh.data_about_gem
    end
  end

  def add_to_list(data)
    @gem_list << data
  end

  def name_handler(argument)
    new_list = []
    name_of_gem = argument.gsub('--name=', '')
    @gem_list.collect do |gem|
      new_list << @gem_list[@gem_list.index(gem)] if gem[:name].include?(name_of_gem)
    end
    @gem_list = new_list
  end
end

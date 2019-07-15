require 'nokogiri'
require 'json'
require 'open-uri'
require 'httparty'
require 'open_uri_redirections'
require 'yaml'
require 'octokit'
require 'terminal-table'
require_relative 'gemhandler'
require_relative 'apihendler'

class UserCommunicator
  attr_reader :rows
  attr_writer :list

  def initialize
    @rows = []
    @list = []
    ARGV.each do |argument|
      @file_name = argument.gsub('--file=', '') if argument.include?('file')
    end
    @file = YAML.safe_load(File.read(@file_name))
    find_list
  end

  def make_top
    @list.sort_by! { |word| word[:rate] }
    @list.each do |gem|
      gem.delete(:rate)
    end
  end

  def load_arguments
    ARGV.each do |argument|
      @list = @list.slice(0, argument[/[0-9]+/].to_i) if argument.include?('top')
      name_handler(argument) if argument.include?('name')
      make_top
      update_row
    end
  end

  def update_row
    @list.each do |gem|
      @rows << gem.values
    end
  end

  def find_list
    @file['gems'].each do |gem_name|
      gem = GemsApiHendler.new(gem_name)
      next unless gem.find_github

      gemh = GemHendler.new(gem.gem_github)
      gemh.join_all_data
      gemh.data_about_gem[:name] = gem_name
      @list << gemh.data_about_gem
    end
  end

  def name_handler(argument)
    # name = argument.gsub('--name=', '')
    new_list = []
    @list.collect do |gem|
      new_list << @list[@list.index(gem)] if gem[:name].include? argument.gsub('--name=', '')
    end
    @list = new_list
  end
end

user = UserCommunicator.new
begin
  user.load_arguments
  table = Terminal::Table.new do |t|
    t.headings = ['watched by', 'stars', 'forks', 'used by', 'contributors', 'issues', 'gem name']
    t.rows = user.rows
  end
  puts table
rescue NoMethodError => e
  puts "ERROR: There isn't any gems in your file"
  puts e.backtrace
end

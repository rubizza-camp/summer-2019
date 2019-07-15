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
  attr_reader :file
  attr_accessor :list

  def make_top
    make_rate
    @list.sort_by! { |word| word[:rate] }
    @list.each do |gem|
      gem.delete(:rate)
    end
  end

  def make_rate
    @list.each do |gem|
      rate = gem[:watched_by] * 0.15 + gem[:stars] * 0.15 + gem[:forks] * 0.10
      rate += gem[:used_by] * 0.5 + gem[:contributers] * 0.05 + gem[:issues] * 0.05
      gem[:rate] = rate
    end
  end

  def load_file
    ARGV.each do |argument|
      @file_name = argument.gsub('--file=', '') if argument.include?('file')
    end
    begin
      @file = YAML.safe_load(File.read(@file_name))
    rescue StandardError => exc
      puts "ERROR: There is no file, named #{@file_name}"
      puts exc
    end
  end

  def load_arguments
    ARGV.each do |argument|
      @rows = []
      if argument.include?('top')
         @list = @list.slice(0, argument[/[0-9]+/].to_i)
      end
      name_handler(argument) if argument.include?('name')
      make_top
      @list.each do |gem|
        @rows << gem.values
      end
    end
    return @rows
  end

  def name_handler(argument)
    name = argument.gsub('--name=', "")
    new_list = []
    @list.collect do |gem|
     if gem[:name].include? name
        ind = @list.index(gem)
        new_list << @list[ind]
     end
    end
    @list = new_list
  end
end

user = UserCommunicator.new
user.load_file
list = []
begin
  user.file['gems'].each do |gem_name|
    gem = GemsApiHendler.new
    gem.gem_name = gem_name
    next if gem.find_github.nil?

    gemh = GemHendler.new(gem.gem_github)
    gemh.join_all_data
    gemh.data_about_gem[:name] = gem_name
    list << gemh.data_about_gem
  end
  user.list = list
  #puts user.list.inspect
  table = Terminal::Table.new :headings => ['watched by', 'stars', 'forks', 'used by', 'contributors', 'issues', 'gem name'], :rows => user.load_arguments
  puts table
rescue NoMethodError => e
  puts "ERROR: There isn't any gems in your file"
  puts e.backtrace
end


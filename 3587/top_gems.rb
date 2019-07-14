require 'mechanize'
require 'optparse'
require './links_modifier.rb'
require './scrape_info.rb'
require './fill_output.rb'
# class that contain main info about gem
class GemStart
  def initialize
    @options = {}
    @array_of_gems = []
    @parser = OptionParser.new do |opt|
      opt.on('--top TOP')
      opt.on('--name NAME')
      opt.on('--file FILE')
    end
    @parser.parse!(into: @options)
    @main_array = []
    run
  end

  def user_option
    file = @options[:file] || 'gem.yaml'
    name = @options[:name] || ''
    top =  @options[:top].to_i
    [file, name, top]
  end

  def parse
    @array_of_gems.each do |gem|
      git_page = LinksModifier.new(gem)
      gem_stat = Scrape.new(git_page.git_page, git_page.used_by_page, gem)
      @main_array << gem_stat.watch
    end
  end

  def run
    file, name, top = user_option
    get_gem_from_file(file, name)
    parse
    FillOutput.new(@main_array, top)
  end

  def get_gem_from_file(file_name, gem_name)
    file = File.open(file_name)
    file.each_line do |line|
      line.gsub!(/[^0-9A-Za-z]/, '')
      @array_of_gems << line if line.include? gem_name
    end
    @array_of_gems.shift if gem_name.empty?
  end
end

GemStart.new

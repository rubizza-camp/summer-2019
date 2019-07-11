require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require './gem_info'
require './options_scraper'
require './scraper'
# I don't think that five instance variables is too much for this case
# Also I think that having them is better than passing useless local vars, so
# :reek:TooManyInstanceVariables and :reek:InstanceVariableAssumption and :reek:TooManyStatements
class TopGems
  LARGE_NUMBER = 1_000_000

  include OptionsScraper
  include Scraper

  def apply_options
    @file = @options[:file] || 'gems.yaml'
    @top = LARGE_NUMBER
    @top = @options[:top].to_i unless @options[:top].to_i.zero?

    @name = @options[:name] || ''
  end

  # Don't see problem here. Link is nil, when it is not valid
  # :reek:NilCheck?
  def fill_hash
    file = YAML.load_file(@file)
    file['gems'].filter { |gem_name| gem_name.start_with? @name }.each do |gem|
      github_link = get_github_link gem
      if github_link.nil?
        puts "Oops, owner of #{gem} hides its code"
        next
      end
      @ranking[gem] = GemInfo.new(gem, github_link)
    end
  end

  def initialize
    @options = parse
    @ranking = {}
    apply_options
    fill_hash
  end

  def rank_print
    @ranking = @ranking.sort_by { |_key, value| value.popularity }
    to_print = @ranking.to_a.take(@top).to_h
    if !to_print.empty?
      to_print.each { |_key, value| puts value }
    else
      puts 'No such gems'
    end
  end
end
top = TopGems.new
top.rank_print

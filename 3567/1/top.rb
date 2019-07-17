require 'yaml'
require 'httparty'
require 'yaml'
require 'open-uri'
require_relative 'html_parser.rb'
require_relative 'api_parser.rb'
require_relative 'output.rb'
require_relative 'score_calculator'
require 'pry'

class Top
  def initialize
    @parameters = load_parametrs
    @api_parser = ApiParser.new
    @html_parser = HTMLParser.new
    @top_of_gems = []
  end

  def create_top
    receive_list_of_gems.each { |gem_name| @top_of_gems << parse_gem_info(gem_name) }
    sort
    receive_gems_via_top
    Output.new(gemstorage: @top_of_gems).create_table
  end

  def sort
    receive_gems_via_name
    calculate_score
    @top_of_gems.sort_by { |item| item[:score] }.reverse
  end

  def calculate_score
    @top_of_gems.each do |item|
      item[:score] = ScoreCalculator.new(gem_data: item).call
    end
  end

  def receive_list_of_gems
    YAML.safe_load(File.read(@parameters[:file] ||= 'gems.yml'))['gems']
  end

  def receive_gems_via_name
    @top_of_gems.select! { |item| item[:repos] == @parameters[:name] } if @parameters[:name]
  end

  def receive_gems_via_top
    @top_of_gems = @top_of_gems.take(@parameters[:top].to_i) if @parameters[:top]
  end

  private

  def load_parametrs
    ARGV.each_with_object({}) do |parameters, hash|
      split = parameters.delete('-').split('=')
      hash[split.first.to_sym] = split.last
    end
  end

  def parse_gem_info(name)
    gems_info = @api_parser.parse(name)
    gems_info.merge!(@html_parser.parse(gems_info[:repos]))
  end
end

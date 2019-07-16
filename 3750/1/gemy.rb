require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require_relative 'statistics'
require_relative 'score'

class Gemy
  def initialize(gem_name)
    @gem_name = gem_name
    @stats = {}
    @scores = {}
    @overall_score = 0
  end

  attr_reader :gem_name
  attr_reader :stats
  attr_reader :overall_score, :scores

  def scrap_overall_score(gem, average_finder)
    @scores = Score.calculate_score_for_each_stat(gem, average_finder)
    @overall_score = Score.calculate_overall_score(gem)
  end

  def scrap_stats
    @stats = Statistics.load_stats(gem_name)
  end
end

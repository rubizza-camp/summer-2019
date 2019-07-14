require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require_relative 'statistics'

class Gemy
  def initialize(gem_name)
    @gem_name = gem_name
    @stats = {}
    @scores = {}
    @overall_score = 0
  end

  attr_accessor :overall_score, :scores
  attr_reader :gem_name
  attr_accessor :stats
end

require 'httparty'
require 'nokogiri'
require 'open-uri'
require_relative 'util'
require_relative 'parser'

class Repo
  attr_reader :info

  def initialize(gem_name)
    parser = Parser.new gem_name
    @info = parser.info
  end

  def rows
    [
      @info['name'].to_s,
      "used by #{@info['used_by']}",
      "watched by #{@info['watched_by']}",
      "#{@info['stars']} stars",
      "#{@info['forks']} forks",
      "#{@info['contributors']} contributors",
      "#{@info['issues']} issues"
    ]
  end
end

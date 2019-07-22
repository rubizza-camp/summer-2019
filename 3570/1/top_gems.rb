# frozen_string_literal: true

require 'bundler'
require 'yaml'
Bundler.require(:default)
require_relative 'outputer'
require_relative 'parser'
require_relative 'option_parse'

class TopGems
  attr_reader :file, :top, :gem_name

  def initialize(file:, top:, name:)
    @file = file
    @gem_name = name
    @top = top
  end

  def run
    gems_info = Parser.new(gems_list(file)).parse
    result = sort_gems(gems_info)
    result = gem_for_name(result) if gem_name
    result = gems_for_top(result) if top
    Outputer.new(result).print
  end

  private

  def sort_gems(gems_info)
    gems_info.sort_by { |info| -info[:stars] }
  end

  def gem_for_name(gems_info)
    gems_info.select { |gem| gem[:name].include?(gem_name) }
  end

  def gems_for_top(gems_info)
    gems_info.take(top)
  end

  def gems_list(file)
    YAML.load_file(file)['gems']
  end
end

TopGems.new(OptionParse.new.parse).run

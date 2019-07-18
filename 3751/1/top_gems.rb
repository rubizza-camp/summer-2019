# frozen_string_literal: true

require_relative 'listing_gems.rb'
require_relative 'get_gem_info.rb'
require_relative 'gem_entity'
require 'terminal-table'
require 'optparse'
require 'gems'
require 'open-uri'
require 'nokogiri'
require 'yaml'
require 'pry'

# output table
# :reek:InstanceVariableAssumption
class GemAnalyze
  # :reek:TooManyStatements
  def call
    gems = ListingGems.new(parameters).load

    gems.sort_by! { |gem| -1 * gem.rating }

    gems = gems.first(parameters[:top]) if parameters[:top]

    print_table(gems)
  end

  def print_table(gems)
    table = Terminal::Table.new rows: gems.map(&:row)
    puts table
  end

  # :reek:TooManyStatements
  def parameters
    return @parameters if defined?(@parameters)

    params = { file: 'gems.yml' }
    OptionParser.new do |opts|
      opts.on('--top=', Integer)
      opts.on('--name=', String)
      opts.on('--file=', String)
    end.parse!(into: params)
    @parameters = params
  end
end

GemAnalyze.new.call

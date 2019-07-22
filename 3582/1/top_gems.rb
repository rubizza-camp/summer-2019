# frozen_string_literal: true

require 'optparse'
require './gem_factory'
require './table_output'
require './gem_reader'

# Main class
class TopGems
  attr_reader :params, :gems

  def initialize
    @params = {}
    @gems = []
  end

  def execute
    commands_parse
    fetch_gems
    sort_gems
    reduce_gems(@params[:top], @params[:name])
    print_gems
  end

  private

  def reduce_gems(top, name)
    @gems = @gems.slice(0..(top - 1)) if top.is_a?(Integer) && top <= @gems.size && top.positive?
    @gems.select! { |elm| elm.gem_name.include?(name) } if name.is_a?(String)
  end

  def sort_gems
    @gems.sort! { |first, second| first.rank < second.rank ? 1 : -1 }
  end

  def print_gems
    TableOutput.new(@gems).execute
  end

  def fetch_gems
    gem_names = GemReader.new(params[:file]).execute
    gem_names.each do |name|
      @gems << GemFactory.build(name)
    end
  end

  def commands_parse
    OptionParser.new do |opts|
      opts.on('--top ')
      opts.on('--file ')
      opts.on('--name ')
    end.parse!(into: @params)

    @params[:top] = @params[:top].to_i if @params[:top]
  end
end

TopGems.new.execute

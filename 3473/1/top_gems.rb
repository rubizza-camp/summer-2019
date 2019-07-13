# frozen_string_literal: true

require 'optparse'
require './gem_info'
require './yaml_parser'
require './table_drawer'

class TopGems
  include YAMLParser

  def start(drawer = TableDrawer.new)
    parse_args
    gems = parse(@options[:file], @options[:name])
    drawer.draw(gems, @options[:top])
  end

  def initialize
    @options = { name: '', top: 10, file: 'list.yml' }
  end

  private

  def parse_args
    create_parser.parse!(into: @options)
    raise ArgumentError, 'Parameter "top" must be positive' unless @options[:top].positive?
    raise ArgumentError, "#{@options[:file]} doesn't exists" unless File.file?(@options[:file])
  rescue OptionParser::InvalidArgument
    raise ArgumentError, 'Parameter "top" must be a number'
  end

  def create_parser
    OptionParser.new do |option|
      option.on('-n', '--name NAME', 'Search by')
      option.on('-t', '--top TOP', OptionParser::DecimalInteger, 'Number of gems')
      option.on('-f', '--file FILE', 'Path to yml file')
    end
  end
end
TopGems.new.start

require 'rubygems'
require_relative 'yaml_reader'
require_relative 'options'
require_relative 'info_taker'
require_relative 'table_maker'

# rubocop:disable Metrics/AbcSize
# :reek:TooManyStatements
# :reek:FeatureEnvy
class GemSearch
  attr_reader :file, :args

  def initialize(file_name, args = ARGV)
    @file = file_name
    @args = args
  end

  def show_info
    search
  end

  private

  def search
    flags = Parser.new(@file, @args).parse

    parsed_yaml = YamlReader.new(flags[:file_name]).parse

    infos = []

    iterator = 0
    while iterator < parsed_yaml[:gems].size
      infos << InfoTaker.new(parsed_yaml[:gems][iterator], parsed_yaml[:adress][iterator]).info
      iterator += 1
    end

    maker = TableMaker.new(infos, flags)
    maker.table
  end
end
# rubocop:enable Metrics/AbcSize

require_relative 'yaml_reader'
require_relative 'options_parser'
require_relative 'info_taker'
require_relative 'table_maker'
require_relative 'gems_selector'

class TopGemsFinder
  def initialize(file_name)
    @file = file_name
  end

  def search
    flags = OptionsParser.new(@file).parse
    infos = []
    YamlReader.new(flags[:file_name]).parse.map do |adress|
      infos << InfoTaker.new(adress).take_info
    end

    TableMaker.new(GemsSelector.new(infos, flags).select_gems).make_table
  end
end

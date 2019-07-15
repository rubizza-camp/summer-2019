require_relative 'yaml_reader'
require_relative 'options_parser'
require_relative 'info_taker'
require_relative 'table_maker'

class GemSearch
  attr_reader :file

  def initialize(file_name)
    @file = file_name
  end

  def search
    flags = OptionsParser.new(@file).parse
    infos = []
    YamlReader.new(flags[:file_name]).parse.map do |adress|
      infos << InfoTaker.new(adress).take_info
    end

    TableMaker.new(infos, flags).make
  end
end

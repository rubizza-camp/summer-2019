require_relative 'yaml_reader'
require_relative 'options'
require_relative 'info_taker'
require_relative 'table_maker'

class GemSearch
  attr_reader :file

  def initialize(file_name)
    @file = file_name
  end

  def search
    flags = Parser.new(@file).parse
    infos = []
    YamlReader.new(flags[:file_name]).parse.each do |adress|
      infos << InfoTaker.new(adress).take_info
    end

    TableMaker.new(infos, flags).table
  end
end

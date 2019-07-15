require_relative 'parse'
require_relative 'option_parser'
require_relative 'read_file'
require_relative 'table'
require_relative 'option_functions'

HEADER = %i[name_id used_by watch stars fork issues contributors].freeze
FILE_NAME = 'list_gems.yml'.freeze

class TopGems
  def initialize
    @gems_from_file = {
      top: []
    }
  end

  def call
    Options.new.call(@gems_from_file)
    names = FileReader.new.call(@gems_from_file)
    gem_data = InfoParser.new.take_information(names)
    top_gems = TopFunction.new.call(gem_data, @gems_from_file)
    Output.new.call(top_gems)
  end
end

TopGems.new.call

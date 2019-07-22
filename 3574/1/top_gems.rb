require_relative 'info_parser'
require_relative 'top_function'
require_relative 'file_reader'
require_relative 'output'
require_relative 'options'

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

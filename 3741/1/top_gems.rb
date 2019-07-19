require 'yaml'

require_relative 'lib/yaml_reader'
require_relative 'lib/gem_data_reader'
require_relative 'lib/gems_view'
require_relative 'lib/my_option_parser'

# main run class
class TopGems
  FILE_NAME = 'gems.yml'.freeze
  def initialize
    @in_args = MyOptionParser.new.options
  end

  def render_table
    gems = read_file.map { |gem_name| GemDataReader.new(gem_name).read }
    GemsView.new(gems).render(top_n: @in_args[:top] || 1_000)
  end

  private

  def read_file
    YamlReader.call(@in_args[:file] || FILE_NAME, @in_args[:name])
  end
end

TopGems.new.render_table

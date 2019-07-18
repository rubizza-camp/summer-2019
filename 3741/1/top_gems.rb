require 'yaml'
require 'optparse'
require_relative 'lib/yaml_reader'
require_relative 'lib/gem_data_reader'
require_relative 'lib/gems_view'

# main run class
class TopGems
  FILE_NAME = 'gems.yml'.freeze
  # :reek:FeatureEnvy
  def initialize
    option_parser = OptionParser.new
    option_parser.on('--top=', '--top') { |value| @option_top = value.to_i }
    option_parser.on('--name=', '--name') { |value| @option_name = value }
    option_parser.on('--file=', '--file') { |value| @option_file = value }
    option_parser.parse!
  end

  def render_table
    gems = read_file.map { |gem_name| GemDataReader.new(gem_name).read }
    GemsView.new(gems).render(top_n: @option_top || 1_000)
  end

  private

  def read_file
    YamlReader.call(@option_file || FILE_NAME, @option_name)
  end
end

TopGems.new.render_table

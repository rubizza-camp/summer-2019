require 'yaml'

require_relative 'lib/yaml_reader'
require_relative 'lib/gem_data_reader'
require_relative 'lib/gems_view'
require_relative 'lib/my_option_parser'

# main run class
class TopGems
  MAX_ITEM_LIST = 1_000
  def self.render_table
    top_gems = TopGems.new
    top_gems.show
  end

  FILE_NAME = 'gems.yml'.freeze

  def initialize
    @options ||= MyOptionParser.parse_options
  end

  def show
    gems = gem_names.map { |gem_name| GemDataReader.read(gem_name) }
    GemsView.new(gems).render(top_n: @options[:top] || MAX_ITEM_LIST)
  end

  private

  def gem_names
    return YamlReader.read(@options[:file], @options[:name]) if @options[:file]
    YamlReader.read(FILE_NAME, @options[:name])
  end
end

TopGems.render_table

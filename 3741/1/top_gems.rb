require 'yaml'
require 'optparse'
require_relative 'lib/read_yaml'
require_relative 'lib/gem_data_reader'
require_relative 'lib/show_table'

# main run class
class TopGems
  # :reek:NestedIterators
  def initialize
    @file_name = 'gems.yml'
    OptionParser.new do |opts|
      opts.on('--top=', '--top') { |value| @option_top = value }
      opts.on('--name=', '--name') { |value| @option_name = value }
      opts.on('--file=', '--file') { |value| @file_name = value }
    end.parse!
  end

  def render_table
    gems = read_file.map { |gem_name| GemDataReader.new(gem_name).read }
    GemsView.new(gems).render(top_n: @option_top || 1_000)
  end

  private

  def read_file
    ReadYaml.call(@file_name, @option_name)
  end
end

TopGems.new.render_table

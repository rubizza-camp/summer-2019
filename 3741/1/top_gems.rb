require 'yaml'
require 'optparse'
require_relative 'lib/read_yaml'
require_relative 'lib/parse_gem_data'
require_relative 'lib/show_table'

# main run class
class TopGems

  def initialize
    @file_name = 'gems.yml'
    OptionParser.new do |opts|
      opts.on('--top=', '--top') { |v| @option_top = v }
      opts.on('--name=', '--name') { |v| @option_name = v }
      opts.on('--file=', '--file') { |v| @file_name = v }
    end.parse!
  end

  def create_table
    gems_name = ReadYaml.call(@file_name, @option_name)
    parse_gem_info = ParseGemData.new
    gems = gems_name.map { |gem_name| parse_gem_info.call(gem_name) }
    gems = prepare_gems(gems)
    GemsView.new.call(gems)
  end

  private

  def prepare_gems(gems)
    gems.sort!.reverse!
    gems = gems.first(@option_top.to_i) if @option_top
    gems
  end
end

TopGems.new.create_table

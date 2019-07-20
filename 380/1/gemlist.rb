require_relative 'gemlistinformation'
require 'Gems'
require 'YAML'

# class include list of gems from file
class GemList
  include GemListInformation

  def initialize(selected_file, selected_name)
    @gem_list = parse_file_with(selected_file, selected_name)
  end

  def with_information
    find_information(@gem_list)
  end

  private

  # :reek:TooManyStatements, :reek:FeatureEnvy, :reek:NilCheck:
  def parse_file_with(file, name)
    file ||= 'gems.yml'
    gem_list = YAML.load_file(file)['gems']
    unless name.nil?
      gem_list.select.with_index { |item, index| gem_list.pop(index) unless item.include?(name) }
    end
    gem_list.map! { |gem| rubygems_response(gem) }
    gem_list.delete_if { |gem| gem.equal?(nil) }
  rescue Errno::ENOENT
    raise "No file '#{file}' in such derictory!"
  end

  def rubygems_response(gem)
    info = Gems.info(gem)
    if info == {}
      puts "No information about <#{gem}> on rubygems."
    else
      info
    end
  end
end

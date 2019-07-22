require_relative 'gemlistinformation'
require 'Gems'
require 'YAML'

# class include list of gems from file
class GemList
  include GemListInformation

  def initialize(options_file, options_name)
    @gem_list = parse_file_with(options_file, options_name)
  end

  def statistics
    find_information(@gem_list)
  end

  private

  # :reek:TooManyStatements, :reek:FeatureEnvy, :reek:NilCheck:
  def parse_file_with(file, name)
    file ||= 'gems.yml'
    gem_list = YAML.load_file(file)['gems']
    gem_list.select! { |item| item.include? name.to_s }
    gem_list.map! { |gem| rubygems_response(gem) }
    gem_list.compact!
  rescue Errno::ENOENT
    raise "No file '#{file}' in such derictory!"
  end

  def rubygems_response(gem)
    if Gems.info(gem).any?
      puts "No information about <#{gem}> on rubygems."
    else
      info
    end
  end
end

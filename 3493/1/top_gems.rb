require 'yaml'
require 'json'
require 'terminal-table'
require './Models/gem_model.rb'
require './Functions/gem_manager.rb'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'open-uri'
require 'gems'

# :reek:UtilityFunction:
def name_instruction(name_gems)
  gem_manager = Functions::GemManager.new
  gem_manager.parse_gem(name_gems: name_gems)
  gem_manager.show_table
end

# :reek:UtilityFunction:
def file_instruction(file_name)
  gem_manager = Functions::GemManager.new
  gem_manager.parse_gem(file_name: file_name)
  gem_manager.show_table
end

# :reek:UtilityFunction:
def top_instruction(top_count)
  gem_manager = Functions::GemManager.new
  gem_manager.parse_gem
  gem_manager.choose_top_gem(top_count)
  gem_manager.show_table
end

def choose_option(setting)
  setting.each do |key, value|
    case key
    when '--top'
      top_instruction(value)
    when '--name'
      name_instruction(value)
    when '--file'
      file_instruction(value)
    end
  end
end

# rubocop:disable Style/RedundantBegin
def main
  begin
    setting = ARGV.map { |argumet| argumet.split('=') }
    setting = { '--file' => 'gems.yml' } if ARGV.empty?
    choose_option(setting.to_h)
  rescue StandardError
    puts 'Please, check list of gems'
  end
end

# rubocop:enable Style/RedundantBegin
main

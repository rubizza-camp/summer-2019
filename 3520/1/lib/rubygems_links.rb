require 'yaml'
DEFAULT_FILE = 'gems.yml'.freeze

class RubyGemsLink
  def initialize
    @link = 'https://rubygems.org/gems/'
    @file = file_to_parse
  end

  def file_to_parse(filename = DEFAULT_FILE)
    @file = filename
  end

  def full_path
    './yaml/' + @file
  end

  def file_check
    File.exist?(full_path)
  end

  def yaml_load
    return YAML.safe_load File.read full_path if file_check

    raise "There is no file by file name #{@file}"
  end

  def yaml_links
    yaml_load['gem'].map { |link| @link + link }
  end

  def gems_name
    yaml_load['gem'].map { |link| link }
  end
end

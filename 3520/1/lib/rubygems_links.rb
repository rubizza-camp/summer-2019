require 'yaml'
DEFAULT_FILE = 'gems.yml'.freeze
RUBYGEMS = 'https://rubygems.org/gems/'.freeze

class RubyGemsLink
  def initialize
    @file = file_to_parse
    @g_hash = {}
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
    return YAML.safe_load(File.read(full_path)) if file_check

    abort "There is no file #{@file}"
  end

  def gems_links
    yaml_load['gem'].map { |link| RUBYGEMS + link }
  end

  def gems_name
    yaml_load['gem'].map { |link| link }
  end

  def gems_hash
    gems_name.zip(gems_links) { |key, value| @g_hash[key] = value }
    @g_hash
  end
end

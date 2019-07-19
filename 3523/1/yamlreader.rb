# frozen_string_literal: true

require 'yaml'
# This is  YamlReader class. This class read yaml files and get gem names
class YamlReader
  attr_reader :file_path, :gem_names

  def initialize(file_path)
    @file_path = file_path
    @gem_names = []
  end

  def read
    @gem_names = YAML.load_file(@file_path)['gems']
  end
end

# frozen_string_literal: true

require 'yaml'
# This is  FileReader class. This class read yaml files and get gem names
class FileReader
  attr_reader :document, :gem_names

  def initialize(file_name)
    @document = file_name
    @gem_names = []
  end

  def read
    @gem_names = YAML.load_file(@document)['gems']
  end
end

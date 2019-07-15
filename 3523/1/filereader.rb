# frozen_string_literal: true

require 'open-uri'
require 'json'
require 'yaml'
# class FileRader
class FileReader
  attr_reader :document, :gem_links

  def initialize(file_name)
    @document = file_name
    @gem_links = []
  end

  def find_links
    read.each do |name|
      link = "https://rubygems.org/api/v1/gems/#{name.strip}"
      @gem_links << JSON.parse(open(link).read)['source_code_uri']
    end
    gem_links
  end

  private

  def read
    YAML.load_file(@document)['gems']
  end
end

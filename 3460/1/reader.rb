# frozen_string_literal: true

require 'open-uri'
require 'json'

# class FileRader
class FileReader
  attr_reader :document, :gem_links

  def initialize(file_name)
    @document = file_name
    @gem_links = []
  end

  def read
    gems = File.readlines(document)
    gems.delete_at(0)
    gems
  end

  def find_links
    refactor(read).each do |name|
      link = "https://rubygems.org/api/v1/gems/#{name.strip}"
      @gem_links << JSON.parse(URI.open(link).read)['source_code_uri']
    end
    gem_links
  end

  private

  # :reek:UtilityFunction
  def refactor(gems)
    gems.map! do |gem|
      gem.delete('-')
    end
  end
end

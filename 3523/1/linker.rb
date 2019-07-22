require 'open-uri'
require 'json'
# This is Linker class. This class get links from https://rubygems.org/api/v1/gems/
class Linker
  attr_reader :gem_names
  def initialize(gem_names)
    @gem_names = gem_names
  end

  def find_links
    @gem_names.map do |name|
      link = "https://rubygems.org/api/v1/gems/#{name.strip}"
      buffer = URI.open(link).read
      JSON.parse(buffer)['source_code_uri']
    end
  end
end

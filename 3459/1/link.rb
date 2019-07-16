# frozen_string_literal: true

require 'open-uri'
require 'json'

# class Link
class Link
  attr_reader :json_file, :gem_links

  def initialize(file_name)
    @json_file = file_name
    @gem_links = []
  end

  def read_file
    gems = File.readlines(json_file)
    gems.delete_at(0)
    gems
  end

  def reception_link
    remove_commas(read_file).each do |name|
      link = JSON.parse(open("https://rubygems.org/api/v1/gems/#{name}").read)
      @gem_links << link['source_code_uri']
    end
    gem_links
  end

  private

  # :reek:UtilityFunction
  def remove_commas(gems)
    gems.map! do |gem|
      gem.delete('-').delete("\n").delete(' ')
    end
  end
end

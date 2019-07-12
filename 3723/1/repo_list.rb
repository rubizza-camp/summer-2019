require 'json'
require 'yaml'
require 'faraday'
require 'nokogiri'
require 'open-uri'

class RepoList
  attr_reader :list, :name

  def initialize(name)
    @list = []
    @name = name
  end

  def write_gem(info)
    response = Faraday.get "https://api.github.com/search/repositories?q=#{info}"
    data = JSON.parse(response.body)
    repo = data['items'][0]['full_name']
    @list << "https://github.com/#{repo}"
  end

  def take_repo(doc)
    doc.dig('gems').map do |info|
      gem_presense = Faraday.get "https://rubygems.org/api/v1/gems/#{info}.json"
      next unless gem_presense.body.include?('name')

      write_gem(info)
    end
  end
end

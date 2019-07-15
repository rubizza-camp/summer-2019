require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

class Link
  def initialize(gem_name)
    @gem_name = gem_name
  end

  def link_to_repo
    agent = Mechanize.new
    page = agent.get("https://rubygems.org/gems/#{@gem_name}")
    (page.links.find { |link| link.text == 'Source Code' }).href
  end
end

# frozen_string_literal: true

require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'json'
require_relative 'filereader'
require_relative 'helper'
# This is GitHubInfo class
class GitHubInfo
  include Helper
  attr_reader :git_hub_info
  def initialize(links)
    @links = links
    @git_hub_info = []
  end

  def info
    @links.each do |link|
      doc = Nokogiri::HTML(open(link))
      used_by_link = Nokogiri::HTML(open("#{link}/network/dependents"))
      @git_hub_info << "#{gem_name(doc)}  #{used_by(used_by_link)} #{watch(doc)}
                #{stars(doc)} #{forks(doc)} #{contributors(doc)} #{issues(doc)}"
    end
    @git_hub_info
  end
end

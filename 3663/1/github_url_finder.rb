# This class look for GitHub gem URL by gem name

require 'mechanize'
require_relative 'yml_parser.rb'

class GitHubUrlFinder
  attr_reader :gems_github_urls_hash

  def initialize(gem_names_array)
    @gems_github_urls_hash = {}
    look_for_gem_github_url(gem_names_array)
  end

  protected

  def look_for_gem_github_url(gem_names_array)
    mechanize = Mechanize.new

    gem_names_array.each do |gem_name|
      gem_rubygems_page = mechanize.get("https://rubygems.org/gems/#{gem_name}")
      gem_github_url = gem_rubygems_page.link_with(text: 'Source Code').uri.to_s
      @gems_github_urls_hash[gem_name.to_sym] = gem_github_url
    end
  end
end

# p gems_github_urls_hash = GitHubUrlFinder.new(["rubocop", "nokogiri", "mechanize"]).gems_github_urls_hash

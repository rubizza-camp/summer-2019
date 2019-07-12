# This class look for GitHub gem URL by gem name

require 'mechanize'
require_relative 'yml_parser.rb'

class GitHubUrlFinder
  attr_reader :gem_rubygems_page, :gem_github_url

  def initialize(gem_name)
    look_for_gem_github_url(gem_name)
  end

  protected

  def look_for_gem_github_url(gem_name)
    mechanize = Mechanize.new
    @gem_rubygems_page = mechanize.get("https://rubygems.org/gems/#{gem_name}")
    @gem_github_url = gem_rubygems_page.link_with(text: 'Source Code').uri.to_s
  end
end

# gem_github_url = GitHubUrlFinder.new(YmlParser.new('gems.yml').gems_hash.values.flatten[0]).gem_github_url

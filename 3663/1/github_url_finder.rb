# This class look for GitHub gem URL by gem name

require 'mechanize'

class GitHubUrlFinder
  attr_reader :gems_github_urls_hash, :mechanize

  RBGM_PAGE = 'https://rubygems.org/gems/'.freeze

  def look_for_gem_github_url(gem_names_array)
    set_mechanize

    gem_names_array.each do |gem_name|
      gem_github_url = mechanize.get(RBGM_PAGE + gem_name).link_with(text: 'Source Code').uri.to_s
      @gems_github_urls_hash[gem_name.to_sym] ||= gem_github_url
    end
    gems_github_urls_hash
  end

  private

  def set_mechanize
    @gems_github_urls_hash ||= {}
    @mechanize = Mechanize.new
  end
end

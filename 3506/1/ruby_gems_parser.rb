require 'nokogiri'
require 'open-uri'

# Class for parsing rubygems.org and take link to github page
class RubyGemsParser
  def parse(gem_name)
    rubygems_url = "https://rubygems.org/gems/#{gem_name}"
    find_github_url('code', rubygems_url) || find_github_url('home', rubygems_url)
  end

  private

  def find_github_url(id, rubygems_url)
    url = Nokogiri::HTML(URI.open(rubygems_url)).css("a##{id}").attr('href')
    url if github_url?(url)
  end

  def github_url?(url)
    return false unless url

    url.text.include?('github')
  end
end

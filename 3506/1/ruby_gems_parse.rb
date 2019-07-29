require 'nokogiri'
require 'open-uri'

# Class for parsing rubygems.org and take link to github page
class RubyGemsParse
  def call(gem_name)
    rubygems_url = "https://rubygems.org/gems/#{gem_name}"
    doc = Nokogiri::HTML(URI.open(rubygems_url))
    find_github_url('code', doc) || find_github_url('home', doc)
  end

  private

  def find_github_url(id, doc)
    url = doc.css("a##{id}").attr('href')
    url if github_url?(url)
  end

  def github_url?(url)
    return false unless url

    url.text.include?('github')
  end
end

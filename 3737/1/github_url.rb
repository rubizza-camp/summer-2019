require 'nokogiri'
require 'open-uri'

# class for getting github page
class GithubUrl
  def search_repo(gem_name)
    rybygems_page = Nokogiri::HTML(open("http://rubygems.org/gems/#{gem_name}"))
    gem_github_url(rybygems_page)
  end

  private

  def gem_github_url(rybygems_page)
    find_github_url('code', rybygems_page) || find_github_url('home', rybygems_page)
  end

  def find_github_url(link_id, url)
    link = url.css("//a[@id=#{link_id}]").attr('href')
    return unless link
    link.text if link.text.include?('github')
  end
end

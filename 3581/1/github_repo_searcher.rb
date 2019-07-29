require 'nokogiri'
require 'open-uri'
require_relative 'github_stat_parser.rb'

class GithubRepoSearcher
  class << self
    def search(name_of_gem)
      page = Nokogiri::HTML(URI.open("https://rubygems.org/gems/#{name_of_gem}"))
      source_code = page.css('a#code')
      home_page = page.css('a#home').attr('href').value
      check_page(source_code, home_page)
    rescue OpenURI::HTTPError
      puts "Gem #{name_of_gem} not found."
    end

    private

    def check_page(source_code, home_page)
      url = ''
      if !source_code.empty?
        source_code = source_code.attr('href').value
        url = source_code
      elsif home_page.include?('github')
        url = home_page
      end
      url
    end
  end
end

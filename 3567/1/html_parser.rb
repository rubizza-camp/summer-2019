require 'open-uri'
require 'nokogiri'

class HTMLParser
  attr_reader :doc
  def initialize
    @doc = doc
  end

  def parse(name)
    {
      Issues: find_issues(name),
      Used_by: find_dependencies(name),
      Contributors: find_contributors(name)
    }
  end

  private

  def find_dependencies(repos)
    @doc = Nokogiri::HTML(open("https://github.com/#{repos}/network/dependents"))
    dependents_number = doc.search('a').select { |element| element.text =~ /Repositories/ }[0].text
    dependents_number.gsub(/[\s,]/, '').to_i
  end

  def find_issues(repos)
    @doc = Nokogiri::HTML(open("https://github.com/#{repos}/issues"))
    issues_number = doc.search('//nav//span[@class="Counter"]')[0].content
    issues_number.to_i
  end

  def find_contributors(repos)
    @doc = Nokogiri::HTML(open("https://github.com/#{repos}/contributors_size"))
    contributors_number = doc.search('span').text
    contributors_number.gsub(/[\s,]/, '').to_i
  end
end

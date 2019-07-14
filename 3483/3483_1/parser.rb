# rubocop:disable Security/Open
# rubocop:disable Metrics/AbcSize

require 'rubygems'
require 'open-uri'
require 'nokogiri'
#:reek:InstanceVariableAssumption and #:reek:TooManyStatements
class Parcer
  def open_first_url(gem_name)
    @url = "https://github.com/rspec/#{gem_name}"
    @html = open(@url)
    @doc = Nokogiri::HTML(@html)
  end

  def open_second_url(gem_name)
    @url = "https://github.com/rspec/#{gem_name}/network/dependents"
    @html = open(@url)
    @doc = Nokogiri::HTML(@html)
  end

  def url_info(gem_name)
    @mass = []
    @mass << gem_name

    open_first_url(gem_name)

    link = @doc.search('main div div li')

    (0..6).each do |elem|
      @mass << link[elem].content.scan(/[A-Za-z0-9,]+/).join(' ')
    end

    open_second_url(gem_name)
    @mass << @doc.css('a[class *="btn-link selected"]').text.scan(/[A-Za-z0-9,]+/).join(' ')
  end
end
# rubocop:enable Security/Open
# rubocop:enable Metrics/AbcSize

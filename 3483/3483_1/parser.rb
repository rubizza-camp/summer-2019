require 'rubygems'
require 'open-uri'
require 'nokogiri'

class Parcer
	def open_first_url(gem_name)
		@url = "https://github.com/#{gem_name}"
        @html = open(@url)
        @doc = Nokogiri::HTML(@html)
	end

	def open_second_url(gem_name)
		@url = "https://github.com/#{gem_name}/network/dependents"
        @html = open(@url)
        @doc = Nokogiri::HTML(@html)
	end

	def url_info(gem_name)
		mass = []

		open_first_url(gem_name)

		link = @doc.search('main div div li')

		(0..6).each do |i|
     	mass << link[i].content.scan(/[A-Za-z0-9,]+/).join(' ')
        end

        open_second_url(gem_name)
        mass << @doc.css('a[class *="btn-link selected"]').text.scan(/[A-Za-z0-9,]+/).join(' ')
        puts mass.inspect
	end
end

test_oop = Parcer.new

test_oop.url_info("rspec/rspec-core")
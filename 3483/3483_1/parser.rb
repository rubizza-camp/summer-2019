require 'rubygems'
require 'open-uri'
require 'nokogiri'

url = 'https://github.com/rspec/rspec-core'
html = open(url)
doc = Nokogiri::HTML(html)

link = doc.search('main div div li')
puts link[0].content
puts link[1].content
puts link[3].content
puts link[4].content
puts link[5].content
puts link[6].content

url = 'https://github.com/rspec/rspec-core/network/dependents'
html = open(url)
doc = Nokogiri::HTML(html)

bla = doc.css('a[class *="btn-link selected"]').text
puts bla


puts 'I work'


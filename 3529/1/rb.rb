require 'nokogiri'
require 'json'
require 'open-uri'

url = 'https://github.com/sparklemotion/nokogiri'
url1 = url+'/network/dependents'
url2 = url + '/issues'
html = open(url)

doc = Nokogiri::HTML(html)
doc1 = Nokogiri::HTML(open(url1))
doc2 = Nokogiri::HTML(open(url2))

# puts doc.css('a.btn-link.selected').text
array_used_stars_forks = Array.new
doc.css('.social-count').each do |tt|
	array_used_stars_forks << tt.text[/[\d*[:punct:]]+/].tr(",", "")
end
puts array_used_stars_forks.inspect
contributers = Array.new
doc.css('ul.numbers-summary li a span.num.text-emphasized').each do |tt|
	contributers << tt.text[/[\d*[:punct:]]+/].tr(",", "")
end
puts contributers.last.to_i
used_by = Array.new
doc1.css('a.btn-link.selected').each do |tt|
	used_by << tt.text[/[\d*[:punct:]]+/].tr(",", "")
end
puts used_by.inspect
issues = Array.new
doc2.css('a.btn-link.selected').each do |tt|
	issues << tt.text[/[\d*[:punct:]]+/].tr(",", "")
end
puts issues.inspect
# puts document.css('a.social-count').text
# puts doc.search("ul.pagehead-actions").children.text
# puts doc.xpath("//a[contains(@href,'https://github.com/sparklemotion/nokogiri/watchers')]")
# puts doc.css('span.num.text-emphasized').text
# binding.pry


# titles   = doc.css('a.btn-link.selected')

# titles.each do |title|
#   puts title.text
# en

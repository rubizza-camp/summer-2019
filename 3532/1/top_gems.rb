# require 'rubygems'
# require 'yaml'
# require 'nokogiri'
# require 'mechanize'
# require 'open-uri'

# config = YAML.load(File.open("gems.yml"))

# x = config["gems"]

# agent = Mechanize.new
# page = agent.get('https://github.com/')

# x.each do |item|
#   puts item.to_s
# end

require 'rubygems'
require 'mechanize'

# mechanize = Mechanize.new
# page = mechanize.get('https://www.gov.uk/')
# form = page.forms.first
# form['q'] = 'passport'
# page = form.submit
# page.search('#results h3').each do |h3|
#   puts h3.text.strip
# end

mechanize = Mechanize.new
page = mechanize.get('https://github.com/')
form = page.forms.first
form['q'] = 'dickhead'
page = form.submit

# page.search('#results h3').each do |h3|
#   puts h3.text.strip
# end
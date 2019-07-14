require 'rubygems'
require 'yaml'
# require 'nokogiri'
require 'mechanize'
require 'open-uri'

config = YAML.load(File.open("gems.yml"))

x = config["gems"]

agent = Mechanize.new
page = agent.get('https://github.com/')

x.each do |item|
  form = page.forms.first
  form['q'] = "#{item.to_s}"
  page = form.submit
end

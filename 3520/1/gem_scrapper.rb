# page = mechanize.get('https://rubygems.org/gems/') # + 'gemname from file'
require 'mechanize'
mechanize = Mechanize.new
page = mechanize.get('https://rubygems.org/gems/sinatra/')
link = page.link_with(id: 'code').click

def used_by(link)
  pulse = link.link_with(href:  /pulse/).click
  dependencies = pulse.link_with(href: /network\/dependencies/).click
  dependendents = dependencies.link_with(text: /Dependent/).click
  dependendents.link_with(text: /Repositories/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
end


def watch(link)
  link.link_with(href: /watchers/).text.split(/\s/).last
end

def star(link)
  test_link.search('a.social-count.js-social-count').first.text.split(/\s/).last
end

def fork(link)
  link.link_with(href: /network\/members/).text.split(/\s/).last
end

def contributors(link)
  # /html/body/div[4]/div/main/div[2]/div[1]/div[2]/div/div/ul/li[4]/a/span
  link.link_with(text: /contributors/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
end

def issues(link)
  # /html/body/div[4]/div/main/div[1]/nav/span[2]/a/span[2]
  link.link_with(text: /Issues/).text.split(/\s/).select { |el| el.size > 1 }.join(' ')
end


# watir

require 'watir'

browser = Watir::Browser.new

browser.goto 'https://rubygems.org/gems/sinatra'
browser.link(text: /Sourse/).click
# browser.button(text: /Star/)
puts browser.title
# => 'Guides – Watir Project'
browser.close

# nokogiri

require 'open-uri'
# url = 'https://rubygems.org/gems/sinatra'
url = 'https://github.com/sinatra/sinatra'
html = open(url)
require 'nokogiri'
doc = Nokogiri::HTML(html)
count = doc.search('div.gem__aside a')
l = doc.css('div.t-list__items a').select { |link| link['id'] == "code" }[0].get_attribute('href')
html = open(l)
s = doc.css('div.repohead-details-container clearfix container ul.pagehead-actions a')

#octokit

require 'octokit'
client = Octokit::Client.new(:login => '', :password => '')
Octokit.repo("sinatra/sinatra")

require 'open-uri'
require 'nokogiri'
require 'json'
require 'terminal-table'
require 'gems'
require 'optparse'

gem = Gems.info 'rails'
gem_uri = Gems.info('rails').key('source_code_uri')
p gem_uri

doc = Nokogiri::HTML(open('http://github.com/rails/rails'), &:huge)

def rails(doc)
  @counts_rails = []
  social = doc.css('a.social-count')
  @counts_rails = social.to_a.map { |x| x.values[2] }
end

def contributors(doc)
  contributors = doc.css('span.num.text-emphasized')
  value = contributors.children[2].to_s.delete('^0-9')
end

def issues(doc)
  issues = doc.css('.Counter')
  value = issues.children[0].to_s.delete('^0-9')
end

# used_by = doc.css('.pagehead-actions > li > a')
# @used = used_by.to_a.map { |x| x.values[2] }

table = Terminal::Table.new do |t|
  t.headings = ['gem', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
  t << ['Rails', 1, rails(doc)[0], rails(doc)[1], rails(doc)[2], contributors(doc), issues(doc)]
  t << :separator
  t.add_row ['gem', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
  t.add_separator
  t.style = { border_top: false, border_bottom: false }
end


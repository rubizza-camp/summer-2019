# rubocop:disable all
# ПРЕДУПРЕЖДЕНИЕ беременным и людям со слабой психикой НЕ читать. Может вызывать приступы эпилепсии и тошноты.
# Гарантированно резкое ухудшение настроение. Имеется риск инфаркта или инсульта. Могут начаться панические атаки

require 'yaml'
require 'gems'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'

gems = YAML.load_file('gems.yml')
rated_hash = {}
total_hash = {}

gems['gems'].each do |i|
  gem_hash = Gems.info i
  if gem_hash['source_code_uri'] != nil
    link = gem_hash['source_code_uri']
  else
    link = gem_hash['homepage_uri']
  end

  main_link = Nokogiri::HTML(open(link))
  watched_by = main_link.css('.social-count')[0].text.tap { |s| s.delete!(',') }.to_i
  stars = main_link.css('.social-count')[1].text.tap { |s| s.delete!(',') }.to_i
  forks = main_link.css('.social-count')[2].text.tap { |s| s.delete!(',') }.to_i
  contributors = main_link.css('span.text-emphasized')[3].text.tap { |s| s.delete!(',') }.to_i

  issues_link = Nokogiri::HTML(open(link + '/issues'))
  open_issues = issues_link.css('.btn-link')[2].text.split[0].tap { |s| s.delete!(',') }.to_i
  closed_issues = issues_link.css('.btn-link')[3].text.split[0].tap { |s| s.delete!(',') }.to_i

  used_link = Nokogiri::HTML(open(link + '/network/dependents'))
  used_by = used_link.css('.btn-link')[1].text
  used_by = used_by.split[0].tap { |s| s.delete!(',') }.to_i

  rating = (watched_by+stars+forks+contributors-open_issues+closed_issues+used_by) / 1000
  total_hash[i] = [watched_by, stars, forks, contributors, open_issues, used_by]
  rated_hash[i] = rating
end

a = rated_hash.sort_by {|k, v| -v}.to_h

rows = []

a.keys.each do |i|
  rows << [i, "used by #{total_hash[i][5]}", "watched by #{total_hash[i][0]}", "#{total_hash[i][1]} stars", "#{total_hash[i][2]} forks", "#{total_hash[i][3]} contributors", "#{total_hash[i][4]} issues"]
end

table = Terminal::Table.new :rows => rows
puts table

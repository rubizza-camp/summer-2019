# rubocop:disable all
# ПРЕДУПРЕЖДЕНИЕ беременным и людям со слабой психикой НЕ читать. Может вызывать приступы эпилепсии и тошноты.
# Гарантированно резкое ухудшение настроение. Имеется риск инфаркта или инсульта. Могут начаться панические атаки

require 'yaml'
require 'gems'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'

if ARGV[0] != nil
  if ARGV[0].include?('--file=')
    path = ARGV[0].delete_prefix('--file=')
  else
    path = 'gems.yml'
  end
else
  path = 'gems.yml'
end

gems = YAML.load_file(path)
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

  rating = watched_by+stars+forks+contributors-open_issues+closed_issues+used_by
  total_hash[i] = [watched_by, stars, forks, contributors, open_issues, used_by]
  rated_hash[i] = rating
end

a = rated_hash.sort_by {|k, v| -v}.to_h

rows = []

a.keys.each do |i|
  rows << [i, "used by #{total_hash[i][5]}", "watched by #{total_hash[i][0]}", "#{total_hash[i][1]} stars", "#{total_hash[i][2]} forks", "#{total_hash[i][3]} contributors", "#{total_hash[i][4]} issues"]
end

top_arr = []

if ARGV[0] != nil
  if ARGV[0].include?('--top=')
    top = ARGV[0].delete_prefix('--top=').to_i
    i = 0
    top.times do
      top_arr << rows[i]
      i += 1
    end
    table = Terminal::Table.new :rows => top_arr
    puts table
  elsif ARGV[0].include?('--name=')
    inc_name = ARGV[0].delete_prefix('--name=')
    total_hash.keys.each do |i|
      if i.to_s.include?(inc_name)
        top_arr << [i, "used by #{total_hash[i][5]}", "watched by #{total_hash[i][0]}", "#{total_hash[i][1]} stars", "#{total_hash[i][2]} forks", "#{total_hash[i][3]} contributors", "#{total_hash[i][4]} issues"]
      end
    end
    table = Terminal::Table.new :rows => top_arr
    puts table
  else
    table = Terminal::Table.new :rows => rows
    puts table
  end
else
  table = Terminal::Table.new :rows => rows
  puts table
end

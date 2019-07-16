require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'
require_relative 'parser'

gems_repo_url = {}
base_url = 'https://rubygems.org/gems/'
top_gems = []

options = CommandLineParser.parse(ARGV)

options[:file] ||= 'gems.yml'

gems = YAML.load_file(options[:file])

gems['gems']. delete_if { |gem| !gem.match?(/#{options[:name]}/) }

gems['gems'].each do |gem|
  url = base_url + gem
  html = URI.parse(url).open
  doc = Nokogiri::HTML(html)
  gems_repo_url[gem] = doc.at_css('[id="code"]')['href'] || doc.at_css('[id="home"]')['href']
end

gems_repo_url.each do |key, value|
  gem_arr = []
  gem_arr << key

  html = URI.parse(value + '/network/dependents').open
  doc = Nokogiri::HTML(html)
  gem_arr << doc.css("a[class = 'btn-link selected']").text.gsub!(/[^\d]/, '').to_i

  html = URI.parse(value).open
  doc = Nokogiri::HTML(html)

  doc.css('a.social-count').each do |score|
    gem_arr << score.text.gsub!(/[^\d]/, '').to_i
  end

  gem_arr << doc.css("span[class ='num text-emphasized']")[3].text.strip.to_i

  gem_arr << doc.at_css('.Counter').text.to_i

  top_gems << gem_arr
end

top_gems.sort_by! { |i| (i[1] + i[2] + i[3] + i[4] + i[5] + i[6]) }.reverse!

top_gems = top_gems[0, options[:top]] unless options[:top].nil?

table = Terminal::Table.new(title: 'Top gems',
                            headings: %w[Gem Used_by Watched Stars Forks Contributors Issues],
                            rows: top_gems)
puts table

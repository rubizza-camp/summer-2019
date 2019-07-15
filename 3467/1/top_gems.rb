require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'
require_relative 'parser'

gem_repo_url = {}
base_url = 'https://rubygems.org/gems/'
top_gems = []

options = CommandLineParser.parse(ARGV)

options[:file] ||= 'gems.yml'

gems = YAML.load_file(options[:file])

gems['gems'].select! { |gem| gem.match?(/#{options[:name]}/) }

# getting repo adresses
gems['gems'].each do |gem|
  url = base_url + gem
  doc = Nokogiri::HTML(URI.open(url))
  gem_repo_url[gem] = doc.at_css('[id="code"]')['href'] || doc.at_css('[id="home"]')['href']
end

# getting array of gems with its params
gem_repo_url.each do |key, value|
  gem_array = []
  gem_array << key

  doc = Nokogiri::HTML(URI.open(value + '/network/dependents'))
  gem_array << doc.css("a[class = 'btn-link selected']").text.gsub!(/[^\d]/, '').to_i

  doc = Nokogiri::HTML(URI.open(value))

  doc.css('a.social-count').each do |score|
    gem_array << score.text.gsub!(/[^\d]/, '').to_i
  end

  gem_array << doc.css("span[class ='num text-emphasized']")[3].text.strip.to_i

  gem_array << doc.at_css('.Counter').text.to_i

  top_gems << gem_array
end

# preparing array of gems with params
top_gems.sort_by! do |arr|
  arr[1] + arr[2] * 10 + arr[3] * 3 + arr[4] * 5 + arr[5] * 10 + arr[6] * 2
end.reverse!

top_gems = top_gems[0, options[:top]] unless options[:top].nil?

# ouput
table = Terminal::Table.new(title: 'Top gems',
                            headings: %w[Gem Used_by Watched Stars Forks Contributors Issues],
                            rows: top_gems)
puts table

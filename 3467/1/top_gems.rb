require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'
require_relative 'parser'

gem_repo_url = {}
base_url = 'https://rubygems.org/gems/'
top_gems = []

# parse command line params
options = CommandLineParser.parse(ARGV)

# reading list of gems(using command line param -f)
options[:file] ||= 'gems.yml'
gems = YAML.load_file(options[:file])

# preparing gem hash according command line parameter -n
begin
  gems['gems'].uniq!
rescue NoMethodError => err
  puts "File #{options[:file]} is empty. Exception encountered: #{err}"
  exit 1
end

gems['gems'].select! { |gem| gem.match?(/#{options[:name]}/) }

raise "There is no gem whith '#{options[:name]}' in name." if gems['gems'].empty?

# getting repo adresses
gems['gems'].each do |gem|
  url = base_url + gem
  begin
    doc = Nokogiri::HTML(URI.open(url))
  rescue OpenURI::HTTPError => err
    puts "There is no '#{gem}' gem on https://rubygems.org. Exception encountered: #{err}"
  else
    gem_repo_url[gem] = doc.css('a#code, a#home').last['href']
  end
end

# getting array of gems with its params from github
gem_repo_url.each do |key, value|
  gem_array = []
  begin
    doc = Nokogiri::HTML(URI.open(value))
    doc_for_used_by = Nokogiri::HTML(URI.open(value + '/network/dependents'))
  rescue OpenURI::HTTPError => err
    puts "Github repositiry '#{gem}' gem not found. Exception encountered: #{err}"
  else
    gem_array << key

    # getting used_by
    gem_array << doc_for_used_by.css("a[class = 'btn-link selected']").text.gsub!(/[^\d]/, '').to_i

    # getting watched, stars, forks
    doc.css('a.social-count').each do |score|
      gem_array << score.text.gsub!(/[^\d]/, '').to_i
    end

    # getting contributors
    gem_array << doc.css("span[class ='num text-emphasized']")[3].text.to_i

    # getting issues
    gem_array << doc.at_css('.Counter').text.to_i
  end
  top_gems << gem_array
end

# preparing array of gems with params by top algoritm & command line param -t
top_gems.sort_by! { |arr| arr[1, 6].sum }.reverse!

top_gems = top_gems[0, options[:top].to_i] unless options[:top].nil?

# ouput top gems
gems_quantity = options[:name] ? "with '#{options[:name]}' in name" : ''
table = Terminal::Table.new(title: "Top #{options[:top]} gems #{gems_quantity} from #{options[:file]}",
                            headings: %w[Gem Used_by Watched Stars Forks Contributors Issues],
                            rows: top_gems)
puts table

require 'yaml'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'
require_relative 'parser'
# :reek:FeatureEnvy
# :reek:NestedIterators
# :reek:NilCheck
# :reek:TooManyStatements
# :reek:UtilityFunction
class TopGems
  attr_reader :options

  def initialize
    @gems_repo_url = {}
    @base_url = 'https://rubygems.org/gems/'
    @top_gems = []
    @options = CommandLineParser.parse(ARGV)
  end

  def contributors(gem)
    Nokogiri::HTML(URI.parse(@base_url + gem).open)
  end

  def depend(value)
    Nokogiri::HTML(URI.parse(value + '/network/dependents').open)
  end

  def parsers(value)
    Nokogiri::HTML(URI.parse(value).open)
  end

  # rubocop:disable Metrics/AbcSize
  def receive_repo_adress
    options[:file] ||= 'gems.yml'
    gems = YAML.load_file(options[:file])
    gems['gems']. delete_if { |gem| !gem.match?(/#{options[:name]}/) }
    gems['gems'].each do |gem|
      doc = contributors(gem)
      @gems_repo_url[gem] = doc.at_css('[id="code"]')['href'] || doc.at_css('[id="home"]')['href']
    end
  end

  # rubocop:disable Metrics/MethodLength
  def receive_array_gems
    @gems_repo_url.each do |key, value|
      gem_array = []
      gem_array << key

      doc = depend(value)
      gem_array << doc.css("a[class = 'btn-link selected']").text.gsub!(/[^\d]/, '').to_i

      doc = parsers(value)

      doc.css('a.social-count').each { |score| gem_array << score.text.gsub!(/[^\d]/, '').to_i }

      gem_array << doc.css("span[class ='num text-emphasized']")[3].text.strip.to_i

      gem_array << doc.at_css('.Counter').text.to_i

      @top_gems << gem_array
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
  end

  def ouput_top_gems
    @top_gems.sort_by! { |array| array[1, 6].sum }.reverse!
    @top_gems = top_gems[options[:top]] unless options[:top].nil?
    table = Terminal::Table.new(title: 'Top gems',
                                headings: %w[Gem Used_by Watched Stars Forks Contributors Issues],
                                rows: @top_gems)
    puts table
  end
end

result = TopGems.new
result.receive_repo_adress
result.receive_array_gems
puts result.ouput_top_gems

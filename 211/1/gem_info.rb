require 'nokogiri'
require_relative './github_page.rb'

class GemInfo
  attr_accessor :name, :watch, :star, :fork, :contrib, :used_by, :issues, :popularity

  def initialize(gem_name)
    @name = gem_name
    GithubPage.new(gem_name).write_files
    @file = File.open("#{gem_name}.html", 'r')
    @doc = Nokogiri::HTML(@file)
    @main_file = File.open("#{gem_name}_main.html", 'r')
    @main_doc = Nokogiri::HTML(@main_file)
  end

  def find_int(css)
    css.text.tr('^0-9', '').to_i
  end

  # rubocop:disable Metrics/AbcSize
  def set_criteria
    @watch = find_int(@doc.css('.social-count')[0])
    @star = find_int(@doc.css('.social-count')[1])
    @fork = find_int(@doc.css('.social-count')[2])
    @issues = find_int(@doc.css('span.Counter')[0])
    @used_by = find_int(@doc.css('a.selected')[3])
    @file.close
    @contrib = find_int(@main_doc.css('span.text-emphasized')[3])
    @main_file.close
  end
  # rubocop:enable Metrics/AbcSize
end
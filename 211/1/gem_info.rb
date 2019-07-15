require 'nokogiri'
require_relative './github_page.rb'

class GemInfo
  attr_reader :name, :watch, :star, :fork, :contrib, :used_by, :issues, :popularity
  attr_writer :popularity
  def initialize(gem_name)
    @name = gem_name
    GithubPage.new(gem_name).write_files
    @file = File.read("#{gem_name}.html")
    @doc = Nokogiri::HTML(@file)
    @main_file = File.read("#{gem_name}_main.html")
    @main_doc = Nokogiri::HTML(@main_file)
  end

  def find_int(css)
    css.text.tr('^0-9', '').to_i
  end

  def criterias
    @watch, @star, @fork = @doc.css('.social-count').map { |el| find_int(el) }
    @issues = find_int(@doc.css('span.Counter')[0])
    @used_by = find_int(@doc.css('a.selected')[3])
  end

  def contribs
    @contrib = find_int(@main_doc.css('span.text-emphasized')[3])
  end
end

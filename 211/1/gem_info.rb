require 'nokogiri'
require_relative './github_page.rb'

class GemInfo
  attr_reader :name, :watch, :star, :fork, :contrib, :used_by, :issues
  attr_accessor :popularity
  WEIGHTS = { used_by: 10, watch: 4, star: 8, fork: 6, contrib: 1, issues: 2 }.freeze
  CRITERIAS = WEIGHTS.keys

  def initialize(gem_name)
    @name = gem_name
    GithubPage.new(@name).write_files
  end

  def call
    read_files
    criterias
    calculate_popularity
    self
  end

  def read_files
    file = File.read("#{@name}.html")
    @doc = Nokogiri::HTML(file)
    contrib_file = File.read("#{@name}_contrib.html")
    @contrib_doc = Nokogiri::HTML(contrib_file)
  end

  def find_int(css)
    css.text.tr('^0-9', '').to_i
  end

  def criterias
    @watch, @star, @fork = @doc.css('.social-count').map { |el| find_int(el) }
    @issues = find_int(@doc.css('span.Counter')[0])
    @used_by = find_int(@doc.css('a.selected')[3])
    @contrib = find_int(@contrib_doc.css('span.text-emphasized')[3])
  end

  def calculate_popularity
    criterias_hash = {}
    CRITERIAS.each do |c|
      criterias_hash[c] = send(c) * WEIGHTS[c]
    end
    self.popularity = criterias_hash.values.reduce(:+)
  end
end

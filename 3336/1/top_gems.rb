require 'open-uri'
require 'nokogiri'
require 'json'
require 'yaml'
require 'rubygems'
require 'gems'
require 'terminal-table'
require 'optparse'

@options = {:top_gem => nil, :name_gem => nil}

OptionParser.new do |parser|
  parser.on('--top=', Integer) do |top|
    puts "I give you #{top} gems"
    @options[:top_gem] = top
  end
  parser.on('--name=', String) do |name|
    puts "Searching for #{name}"
    @options[:name_gem] = name
  end
  parser.on('--file')
end.parse!

def initialize
  @gem_hash = []
  @doc = []
  @second_doc = []
  @stats = []
  @contributers = []
  @issues = []
  @used_by = []
  @arr_of_stats = %i[watch star fork contributers issues used_by]
  @hash_stat = {}
end

def yaml_parse
  initialize
  data = YAML.safe_load(File.read('gems.yaml'))
  @arr_of_gems = Array.new(data['gems'].delete('-').split(' '))

  if @options[:name_gem] = nil
    @arr_of_gems.each do |item|
      unless item.include?(@options[:name_gem])
        @arr_of_gems.delete(item)
      end
    end
  end
  p @arr_of_gems
end

def check_for_optparse
  if @options[:top_gem] == nil
    @options[:top_gem] = @arr_of_gems.length
  end 
  if @options[:name_gem] == nil
    @options[:top_gem] = @arr_of_gems.length
  end
end

def takin_sources
  yaml_parse
  @arr_of_gems.each do |url|
    @gem_hash << Gems.info(url)['source_code_uri']
  end
  # p @gem_hash
  @gem_hash.each do |el|
    @doc << Nokogiri::HTML(open(el))
    @second_doc << Nokogiri::HTML(open(el + '/network/dependents'))
  end
end

def parsing_url
  takin_sources

  @doc.each do |el|
    @stats << el.css('a.social-count').text.delete(' ').delete(',').split("\n").reject(&:empty?).map(&:to_i)
    @contributers << el.css('span.num.text-emphasized')[3].text.delete(' ').delete(',').split("\n").reject(&:empty?).map(&:to_i)
    @issues << [el.css('span.Counter')[0].text.to_i]
  end

  @second_doc.each do |el|
    @used_by << [el.css('.btn-link')[1].text.delete(' ').delete("\n").delete(',').to_i]
  end
end

# Set up an array with url's
def arr_to_hash
  parsing_url
  @arr_n = []
  @arr_n = @stats.concat(@contributers).concat(@issues).concat(@used_by)
  l = @arr_of_gems.length
  @arr_of_gems.each_index do |i|
    @arr_n[i] = @arr_n[i].concat(@arr_n[i + l]).concat(@arr_n[i + 2 * l]).concat(@arr_n[i + 3 * l])
  end
  @arr_n.delete_if { |index| index.length < 5 }
  # p arr_n
  @arr_of_gems.each_with_index do |val, i|
    @hash_stat[val.to_sym] = Hash[@arr_of_stats.zip(@arr_n[i])]
  end
  p @arr_n
end



def rating 
    arr_to_hash
    check_for_optparse
    arr_rate = []
    rows =[]

    @arr_of_gems.each_index do |i|
      p arr_rate[i] = @arr_n[i].sum
    end

    @arr_of_gems.each_index do |i|
      @arr_n[i].unshift(@arr_of_gems[i]).push(arr_rate[i])
      rows << @arr_n[i]
    end

    # p rows
    rows.each do |i|
      rows.sort_by! do |item|
        item.last
      end
    end
    p rows.reverse!
    num_g = @options[:top_gem] - 1
    table = Terminal::Table.new :rows => rows[0..num_g], :headings => @arr_of_stats.unshift('GEM').push('Rating')
    puts table
    p @options
end

rating

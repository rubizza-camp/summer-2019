require './yaml_parser.rb'
require './link_builder.rb'
require './info_collector'
require './table_builder'
require 'terminal-table'

class TopGems
  def initialize(options)
    @options = options
    @source = 'top_gems.yaml'
    @top_size = 7
    @filter = nil
  end

  def size(option)
    @top_size = option.split('=').last.to_i if option.include?('--top')
    p "showing top #{@top_size} gem(s)"
  end

  def sources(option)
    @source = option.split('=').last if option.include?('--file')
    p "source file is #{@source}"
  end

  def filter(option)
    if option.include?('--name')
      @filter = option.split('=').last.capitalize
      p "showing #{@filter}"
    else
      p 'searching for all gems'
    end
  end

  def parse_options
    @options.each do |option|
      size(option)
      sources(option)
      filter(option)
    end
  end

  def get_info(links)
    all_gems_info = []
    p 'collecting info'
    links.each { |link| all_gems_info << InfoCollector.new(link).result }
    all_gems_info
  end

  def receive_links(all_gems)
    p 'receiving links'
    links = []
    all_gems.each { |gem| links << LinkBuilder.new(gem).build_github_link }
    links
  end

  def display_result(result)
    result = result.first(@top_size)
    result.select! { |gem| gem.include?(@filter) } unless @filter.class != 'string'
    table = TableBuilder.new(result).build_table
    puts table
  end

  def sort_and_display(result)
    result.sort_by! { |gem_info| gem_info[1] }.reverse!
    display_result(result)
  end

  def execute
    parse_options
    links = receive_links(YamlParser.new(@source).parse)
    result = get_info(links)
    sort_and_display(result)
  end
end

TopGems.new(ARGV).execute

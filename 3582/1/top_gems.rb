# frozen_string_literal: true

require 'optparse'
require 'yaml'
require './factory'
require 'pry'
require 'terminal-table'

# Main class, it parses commands, reads file, fetches info about gems,
# outputs concrete (specified) gems
class TopGems
  HEADING_TABLE = ['name', 'used by', 'watchers', 'stars', 'forks', 'contributors', 'issues'].freeze

  attr_reader :params, :gems, :machina

  def initialize
    @params = {}
    @gems = []
  end

  def execute
    commands_parse
    fetch_gems
    sort_gems
    reduce_gems(@params[:top], @params[:name])
    print_gems
  end

  private

  def print_gems
    table_str = @gems.map do |gemi|
      create_string_table(gemi)
    end
    print_table(table_str)
  end

  def create_string_table(gemi)
    [
      gemi.gem_name, gemi.params[:used_by],
      gemi.params[:watchers], gemi.params[:stars],
      gemi.params[:forks], gemi.params[:contributors],
      gemi.params[:issues]
    ]
  end

  def print_table(tb_data)
    table = Terminal::Table.new headings: HEADING_TABLE, rows: tb_data
    puts table
  end

  def reduce_gems(top, name)
    @gems = @gems.slice(0..(top - 1)) if top.is_a?(Integer) && top <= @gems.size && top.positive?
    @gems.select! { |elm| elm.gem_name.include?(name) } if name.is_a?(String)
  end

  def sort_gems
    @gems.sort! { |first, second| first.rank < second.rank ? 1 : -1 }
  end

  def fetch_gems
    gem_names = open_file(params[:file])
    gem_names.each do |name|
      @gems << GemFactory.build(name)
    end
  end

  def commands_parse
    OptionParser.new do |opts|
      opts.on('--top ')
      opts.on('--file ')
      opts.on('--name ')
    end.parse!(into: @params)

    @params[:top] = @params[:top].to_i if @params[:top]
  end

  def open_file(file)
    begin
      raise Errno::ENOENT unless file.is_a?(String)

      gem_names = YAML.load_file(file).dig('gems')
    rescue Errno::ENOENT
      gem_names = %w[sinatra rspec rails nokogiri]
      puts "File Doesn't exist or not specifeid, loading deafult gems"
    end
    gem_names
  end
end

TopGems.new.execute

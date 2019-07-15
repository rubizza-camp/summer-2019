require 'yaml'
require_relative 'parser.rb'
require 'terminal-table'
require 'optparse'

# class that show gems with their's stats
class TopGems
  def initialize
    @top_gems = {}
  end

  def gems_file
    options_for_gems
    file = YAML.load_file(@options[:file])
    file = file['gems']
    file.each do |lib|
      values = Parser.new.repository(lib)
      next if values.nil?
      @top_gems[lib] = values
    end
    options_select
  end

  def tableshow
    Terminal::Table.new do |t|
      @top_gems.each do |key, val|
        t << [
          key, "used by #{val[:used_by]}", "watch #{val[:watch]}",
          "forks #{val[:forks]}", "stars #{val[:star]}",
          "issues #{val[:issues]}", "contributors #{val[:contributors]}"
        ]
      end
    end
  end

  def options_for_gems
    @options = {}
    @options[:file] = 'gems.yml'
    OptionParser.new do |opt|
      opt.on('-t', '--top = t', Integer) { |t| @options[:top] = t }
      opt.on('-n', '--name = n', String) { |n| @options[:name] = n }
      opt.on('-f', '--file = f', String) { |f| @options[:file] = f }
    end.parse!
  end

  def options_select
    @top_gems.select! { |key, _| key.include?(@options[:name]) } if @options[:name]
    top
    puts tableshow
  end

  def top
    return @top_gems = @top_gems.sort_by{ |_, arr| -arr[:total] }[0..@options[:top] - 1].to_h if @options[:top]
    @top_gems = @top_gems.sort_by { |_, arr| -arr[:total] }.to_h
  end
end

TopGems.new.gems_file

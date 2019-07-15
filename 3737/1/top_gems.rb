require 'optparse'
require_relative 'parser.rb'
require 'terminal-table'
require 'yaml'

# class that show gems with their's stats
class TopGems
  def initialize
    @top_gems = {}
  end

  def gems_file
    options_for_gems
    file = YAML.load_file(@options[:file])
    file['gems'].each do |lib|
      values = Parser.new.repository(lib)
      next if values.nil?
      @top_gems[lib] = values
    end
    options_select
  end

  def tableshow
    Terminal::Table.new do |tab|
      @top_gems.each do |key, val|
        tab << [
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
      opt.on('-t', '--top = top', Integer) { |top| @options[:top] = top }
      opt.on('-n', '--name = nam', String) { |nam| @options[:name] = nam }
      opt.on('-f', '--file = file', String) { |file| @options[:file] = file }
    end.parse!
  end

  def options_select
    same_gem_name
    top
    puts tableshow
  end

  def same_gem_name
    return unless @options[:name]
    @top_gems.select! { |key, _| key.include?(@options[:name]) }
  end

  def top
    return @top_gems = @top_gems.sort_by { |_, arr| -arr[:total] }[0..@options[:top] - 1].to_h if @options[:top]
    @top_gems = @top_gems.sort_by { |_, arr| -arr[:total] }.to_h
  end
end

TopGems.new.gems_file

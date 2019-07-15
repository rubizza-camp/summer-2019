require 'optparse'
require_relative 'parser.rb'
require 'terminal-table'
require 'yaml'

# class that show gems with their's stats
class TopGems
  def initialize
    @gems = {}
  end

  def gems_file
    options_for_gems
    file = YAML.load_file(@optn[:file])
    file['gems'].each do |lib|
      values = Parser.new.repository(lib)
      next if values.nil?
      @gems[lib] = values
    end
    options_select
  end

  def tableshow
    Terminal::Table.new do |tab|
      @gems.each do |key, val|
        tab << [
          key, "used by #{val[:used_by]}", "watch #{val[:watch]}",
          "forks #{val[:forks]}", "stars #{val[:star]}",
          "issues #{val[:issues]}", "contributors #{val[:contributors]}"
        ]
      end
    end
  end

  def options_for_gems
    @optn = {}
    @optn[:file] = 'gems.yml'
    OptionParser.new do |opt|
      opt.on('-t', '--top = top', Integer) { |top| @optn[:top] = top }
      opt.on('-n', '--name = nam', String) { |nam| @optn[:name] = nam }
      opt.on('-f', '--file = file', String) { |file| @optn[:file] = file }
    end.parse!
  end

  def options_select
    same_gem_name
    top
    puts tableshow
  end

  def same_gem_name
    return unless @optn[:name]
    @gems.select! { |key, _| key.include?(@optn[:name]) }
  end

  def top
    puts @gems
    return @gems = @gems.sort_by { |_, arr| -arr[:sum] }[0..@optn[:top] - 1].to_h if @optn[:top]
    @gems = @gems.sort_by { |_, arr| puts arr; -arr[:sum] }.to_h
  end
end

TopGems.new.gems_file

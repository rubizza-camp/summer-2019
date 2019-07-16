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
    optn = options_for_gems
    file = YAML.load_file(optn[:file])
    takegems(file['gems'])
    options_select(optn)
  end

  private

  def takegems(file)
    file.each do |lib|
      values = Parser.new.repository(lib)
      next unless values
      @gems[lib] = values
    end
  end

  # :reek:FeatureEnvy and :reek:NestedIterators
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

  #:reek:NestedIterators and :reek:TooManyStatements
  def options_for_gems
    optn = {}
    optn[:file] = 'gems.yml'
    OptionParser.new do |opt|
      opt.on('-t', '--top = top', Integer) { |top| optn[:top] = top }
      opt.on('-n', '--name = nam', String) { |nam| optn[:name] = nam }
      opt.on('-f', '--file = file', String) { |file| optn[:file] = file }
    end.parse!
    optn
  end

  def options_select(opt)
    same_gem_name(opt)
    top(opt)
    puts tableshow
  end

  def same_gem_name(opt)
    nm = opt[:name]
    return unless nm
    @gems.select! { |key, _| key.include?(nm) }
  end

  def top(opt)
    return @gems = @gems.sort_by { |_, arr| -arr[:sum] }[0..opt[:top] - 1].to_h if opt[:top]
    @gems = @gems.sort_by { |_, arr| -arr[:sum] }.to_h
  end
end

TopGems.new.gems_file

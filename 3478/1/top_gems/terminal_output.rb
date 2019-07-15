require 'terminal-table'

class TerminalOutput
  HEADER = %w[Name Used_by Watchers Stars Forks Contributors Issues].freeze

  def initialize(gem_top, top_size, contains_in_name)
    top_size ||= gem_top.size
    @top_size = top_size.to_i
    @contains_in_name = contains_in_name
    @gem_top = prepare_top(gem_top)
    @rows = []
  end

  def prepare_top(gem_top)
    gem_top.sort_by! { |gem| - gem[:total_score] }.take(@top_size)
  end

  def print_top
    @gem_top.each do |gem|
      next unless appropriate_name?(gem)
      create_new_position_in_top(gem)
    end
    puts Terminal::Table.new headings: HEADER, rows: @rows
  end

  private

  def create_new_position_in_top(gem)
    all_fields = %i[name used_by watchers stars forks contributors issues].freeze
    @rows << gem.values_at(*all_fields)
  end

  def appropriate_name?(gem)
    gem[:name] =~ /#{@contains_in_name}/
  end
end

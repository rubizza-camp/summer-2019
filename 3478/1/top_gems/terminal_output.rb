require 'terminal-table'

class TerminalOutput
  HEADER = %w[Name Used_by Watchers Stars Forks Contributors Issues].freeze

  def print_top(gem_top, top_size, contains_in_name)
    top_size ||= gem_top.size
    rows = []
    gem_top.each do |gem|
      next unless appropriate_name?(gem, contains_in_name)
      retun if rows.size >= top_size
      rows << create_new_position_in_top(gem)
    end
    table = Terminal::Table.new headings: HEADER, rows: rows
    puts table
  end

  def create_new_position_in_top(gem)
    position = [] << gem.name << gem.used_by << gem.watchers << gem.stars
    position << gem.forks << gem.contributors << gem.issues
    position
  end

  def appropriate_name?(gem, contains_in_name)
    gem.name =~ /#{contains_in_name}/
  end
end

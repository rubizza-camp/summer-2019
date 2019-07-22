# frozen_string_literal: true

require 'terminal-table'
require 'ruby-progressbar'

class TableDrawer
  def draw(data, top)
    progressbar = ProgressBar.create(total: data.size, title: 'github parsing', output: $stderr)
    puts Terminal::Table.new(rows: data(top, data, progressbar))
  end

  private

  def data(top, gems, progressbar)
    gems.sort_by do |item|
      weight = item.rank
      progressbar.increment
      -weight
    end.take(top).map(&method(:to_row))
  end

  def to_row(item)
    [item.name, "used by #{item.params[:used]}", "watched by #{item.params[:watch]}",
     "#{item.params[:star]} stars", "#{item.params[:fork]} forks",
     "#{item.params[:contributor]} contributors", "#{item.params[:issue]} issues"]
  end
end
